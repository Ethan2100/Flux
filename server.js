// Flux backend: real accounts, a real Postgres database, and real
// image uploads. This part is plain Node/Express - Volt has no concept of
// routes, databases, or auth, so it isn't meaningfully "Volt code," it's
// just a normal server the Volt-built frontend talks to over HTTP.

const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cookieParser = require('cookie-parser');
const multer = require('multer');
const path = require('path');

const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET || 'dev-secret-change-in-production';
const DATABASE_URL = process.env.DATABASE_URL;

if (!DATABASE_URL) {
  console.error('Missing DATABASE_URL - set it before starting the server.');
  process.exit(1);
}

// Render's internal DB URL (if ever used again) doesn't need SSL; everything
// else - Neon, Render's external URL, most hosted Postgres - does.
const needsSsl =
  DATABASE_URL.includes('neon.tech') ||
  DATABASE_URL.includes('sslmode=require') ||
  (DATABASE_URL.includes('render.com') && !DATABASE_URL.includes('internal'));

const pool = new Pool({
  connectionString: DATABASE_URL,
  ssl: needsSsl ? { rejectUnauthorized: false } : false,
});

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
});

// Stories can be short videos, so they get a bigger limit than photo posts.
const storyUpload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 20 * 1024 * 1024 }, // 20MB
});

async function initDb() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      username TEXT UNIQUE NOT NULL,
      password_hash TEXT NOT NULL,
      created_at TIMESTAMPTZ DEFAULT now()
    );
  `);
  await pool.query(`ALTER TABLE users ADD COLUMN IF NOT EXISTS bio TEXT NOT NULL DEFAULT '';`);
  await pool.query(`ALTER TABLE users ADD COLUMN IF NOT EXISTS avatar_data BYTEA;`);
  await pool.query(`ALTER TABLE users ADD COLUMN IF NOT EXISTS avatar_type TEXT;`);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS posts (
      id SERIAL PRIMARY KEY,
      user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      caption TEXT NOT NULL DEFAULT '',
      image_data BYTEA NOT NULL,
      image_type TEXT NOT NULL,
      created_at TIMESTAMPTZ DEFAULT now()
    );
  `);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS likes (
      user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
      PRIMARY KEY (user_id, post_id)
    );
  `);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS stories (
      id SERIAL PRIMARY KEY,
      user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      media_data BYTEA NOT NULL,
      media_type TEXT NOT NULL,
      created_at TIMESTAMPTZ DEFAULT now(),
      expires_at TIMESTAMPTZ NOT NULL DEFAULT (now() + interval '24 hours')
    );
  `);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS story_views (
      user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      story_id INTEGER NOT NULL REFERENCES stories(id) ON DELETE CASCADE,
      viewed_at TIMESTAMPTZ DEFAULT now(),
      PRIMARY KEY (user_id, story_id)
    );
  `);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS follows (
      follower_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      following_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      created_at TIMESTAMPTZ DEFAULT now(),
      PRIMARY KEY (follower_id, following_id)
    );
  `);
  console.log('Database ready.');
}

const app = express();
app.use(express.json());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

function signToken(user) {
  return jwt.sign({ id: user.id, username: user.username }, JWT_SECRET, { expiresIn: '30d' });
}

function auth(req, res, next) {
  const token = req.cookies.token;
  if (!token) return next();
  try {
    req.user = jwt.verify(token, JWT_SECRET);
  } catch (e) {
    // bad/expired token - just treat as logged out
  }
  next();
}
app.use(auth);

function requireAuth(req, res, next) {
  if (!req.user) return res.status(401).json({ error: 'Not logged in' });
  next();
}

const USERNAME_RE = /^[a-zA-Z0-9_.]{3,20}$/;

function usernameError(username) {
  if (!username) return 'Username is required.';
  if (username.includes('@')) return 'Use a username, not an email address.';
  if (!USERNAME_RE.test(username)) return 'Username must be 3-20 characters: letters, numbers, underscores, or dots.';
  return null;
}

// ---- Auth routes ----

app.post('/api/signup', async (req, res) => {
  const { username, password } = req.body || {};
  const uErr = usernameError(username);
  if (uErr) return res.status(400).json({ error: uErr });
  if (!password || password.length < 4) {
    return res.status(400).json({ error: 'Password (4+ chars) required.' });
  }
  try {
    const hash = await bcrypt.hash(password, 10);
    const result = await pool.query(
      'INSERT INTO users (username, password_hash) VALUES ($1, $2) RETURNING id, username',
      [username, hash]
    );
    const user = result.rows[0];
    const token = signToken(user);
    res.cookie('token', token, { httpOnly: true, maxAge: 30 * 24 * 60 * 60 * 1000, sameSite: 'lax' });
    res.json({ id: user.id, username: user.username });
  } catch (e) {
    if (e.code === '23505') return res.status(409).json({ error: 'That username is taken.' });
    console.error(e);
    res.status(500).json({ error: 'Signup failed.' });
  }
});

app.post('/api/login', async (req, res) => {
  const { username, password } = req.body || {};
  if (!username || !password) return res.status(400).json({ error: 'Username and password required.' });
  try {
    const result = await pool.query('SELECT id, username, password_hash FROM users WHERE username = $1', [username]);
    const user = result.rows[0];
    if (!user || !(await bcrypt.compare(password, user.password_hash))) {
      return res.status(401).json({ error: 'Wrong username or password.' });
    }
    const token = signToken(user);
    res.cookie('token', token, { httpOnly: true, maxAge: 30 * 24 * 60 * 60 * 1000, sameSite: 'lax' });
    res.json({ id: user.id, username: user.username });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Login failed.' });
  }
});

app.post('/api/logout', (req, res) => {
  res.clearCookie('token');
  res.json({ ok: true });
});

app.get('/api/me', async (req, res) => {
  if (!req.user) return res.json(null);
  try {
    const result = await pool.query(
      'SELECT id, username, bio, (avatar_data IS NOT NULL) AS has_avatar FROM users WHERE id = $1',
      [req.user.id]
    );
    res.json(result.rows[0] || null);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not load account.' });
  }
});

// ---- Account management ----

app.patch('/api/me', requireAuth, async (req, res) => {
  const { username, bio } = req.body || {};
  const sets = [];
  const values = [];
  if (username !== undefined) {
    const uErr = usernameError(username);
    if (uErr) return res.status(400).json({ error: uErr });
    values.push(username);
    sets.push('username = $' + values.length);
  }
  if (bio !== undefined) {
    values.push(String(bio).slice(0, 150));
    sets.push('bio = $' + values.length);
  }
  if (!sets.length) return res.status(400).json({ error: 'Nothing to update.' });
  values.push(req.user.id);
  try {
    const result = await pool.query(
      `UPDATE users SET ${sets.join(', ')} WHERE id = $${values.length} RETURNING id, username, bio, (avatar_data IS NOT NULL) AS has_avatar`,
      values
    );
    const user = result.rows[0];
    const token = signToken(user);
    res.cookie('token', token, { httpOnly: true, maxAge: 30 * 24 * 60 * 60 * 1000, sameSite: 'lax' });
    res.json(user);
  } catch (e) {
    if (e.code === '23505') return res.status(409).json({ error: 'That username is taken.' });
    console.error(e);
    res.status(500).json({ error: 'Could not update account.' });
  }
});

app.post('/api/me/password', requireAuth, async (req, res) => {
  const { currentPassword, newPassword } = req.body || {};
  if (!currentPassword || !newPassword || newPassword.length < 4) {
    return res.status(400).json({ error: 'Current password and a new password (4+ chars) are required.' });
  }
  try {
    const result = await pool.query('SELECT password_hash FROM users WHERE id = $1', [req.user.id]);
    const row = result.rows[0];
    if (!row || !(await bcrypt.compare(currentPassword, row.password_hash))) {
      return res.status(401).json({ error: 'Current password is wrong.' });
    }
    const hash = await bcrypt.hash(newPassword, 10);
    await pool.query('UPDATE users SET password_hash = $1 WHERE id = $2', [hash, req.user.id]);
    res.json({ ok: true });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not change password.' });
  }
});

app.post('/api/me/avatar', requireAuth, upload.single('avatar'), async (req, res) => {
  if (!req.file) return res.status(400).json({ error: 'An image is required.' });
  try {
    await pool.query('UPDATE users SET avatar_data = $1, avatar_type = $2 WHERE id = $3', [
      req.file.buffer,
      req.file.mimetype,
      req.user.id,
    ]);
    res.json({ ok: true });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not update avatar.' });
  }
});

// ---- Public profiles ----

app.get('/api/users/:username', async (req, res) => {
  const viewerId = req.user ? req.user.id : 0;
  try {
    const result = await pool.query(
      `SELECT id, username, bio, (avatar_data IS NOT NULL) AS has_avatar,
              (SELECT COUNT(*)::int FROM posts WHERE user_id = users.id) AS post_count,
              (SELECT COUNT(*)::int FROM follows WHERE following_id = users.id) AS follower_count,
              (SELECT COUNT(*)::int FROM follows WHERE follower_id = users.id) AS following_count,
              EXISTS(SELECT 1 FROM follows WHERE follower_id = $1 AND following_id = users.id) AS is_following
       FROM users WHERE username = $2`,
      [viewerId, req.params.username]
    );
    if (!result.rows.length) return res.status(404).json({ error: 'User not found.' });
    res.json(result.rows[0]);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not load profile.' });
  }
});

app.post('/api/users/:username/follow', requireAuth, async (req, res) => {
  try {
    const target = await pool.query('SELECT id FROM users WHERE username = $1', [req.params.username]);
    if (!target.rows.length) return res.status(404).json({ error: 'User not found.' });
    const targetId = target.rows[0].id;
    if (targetId === req.user.id) return res.status(400).json({ error: "You can't follow yourself." });

    const existing = await pool.query('SELECT 1 FROM follows WHERE follower_id = $1 AND following_id = $2', [
      req.user.id,
      targetId,
    ]);
    if (existing.rows.length) {
      await pool.query('DELETE FROM follows WHERE follower_id = $1 AND following_id = $2', [req.user.id, targetId]);
    } else {
      await pool.query('INSERT INTO follows (follower_id, following_id) VALUES ($1, $2)', [req.user.id, targetId]);
    }
    const counts = await pool.query('SELECT COUNT(*)::int AS n FROM follows WHERE following_id = $1', [targetId]);
    res.json({ following: !existing.rows.length, follower_count: counts.rows[0].n });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not update follow.' });
  }
});

app.get('/api/search/users', async (req, res) => {
  const q = (req.query.q || '').trim();
  if (!q) return res.json([]);
  try {
    const result = await pool.query(
      `SELECT username, bio, (avatar_data IS NOT NULL) AS has_avatar
       FROM users WHERE username ILIKE $1 ORDER BY username LIMIT 20`,
      ['%' + q + '%']
    );
    res.json(result.rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Search failed.' });
  }
});

app.get('/api/users/:username/avatar', async (req, res) => {
  try {
    const result = await pool.query('SELECT avatar_data, avatar_type FROM users WHERE username = $1', [req.params.username]);
    const row = result.rows[0];
    if (!row || !row.avatar_data) return res.status(404).end();
    res.set('Content-Type', row.avatar_type);
    res.set('Cache-Control', 'public, max-age=3600');
    res.send(row.avatar_data);
  } catch (e) {
    console.error(e);
    res.status(500).end();
  }
});

app.get('/api/users/:username/posts', async (req, res) => {
  const userId = req.user ? req.user.id : 0;
  try {
    const result = await pool.query(
      `SELECT p.id, p.caption, p.created_at, u.username, (u.avatar_data IS NOT NULL) AS has_avatar,
              (SELECT COUNT(*)::int FROM likes WHERE post_id = p.id) AS likes,
              EXISTS(SELECT 1 FROM likes WHERE post_id = p.id AND user_id = $1) AS liked_by_me
       FROM posts p
       JOIN users u ON u.id = p.user_id
       WHERE u.username = $2
       ORDER BY p.created_at DESC
       LIMIT 100`,
      [userId, req.params.username]
    );
    res.json(result.rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not load posts.' });
  }
});

// ---- Posts routes ----

app.get('/api/posts', async (req, res) => {
  const userId = req.user ? req.user.id : 0;
  try {
    const result = await pool.query(
      `SELECT p.id, p.caption, p.created_at, u.username, (u.avatar_data IS NOT NULL) AS has_avatar,
              (SELECT COUNT(*)::int FROM likes WHERE post_id = p.id) AS likes,
              EXISTS(SELECT 1 FROM likes WHERE post_id = p.id AND user_id = $1) AS liked_by_me
       FROM posts p
       JOIN users u ON u.id = p.user_id
       ORDER BY p.created_at DESC
       LIMIT 50`,
      [userId]
    );
    res.json(result.rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not load posts.' });
  }
});

app.post('/api/posts', requireAuth, upload.single('image'), async (req, res) => {
  if (!req.file) return res.status(400).json({ error: 'An image is required.' });
  const caption = (req.body.caption || '').slice(0, 300);
  try {
    const result = await pool.query(
      'INSERT INTO posts (user_id, caption, image_data, image_type) VALUES ($1, $2, $3, $4) RETURNING id',
      [req.user.id, caption, req.file.buffer, req.file.mimetype]
    );
    res.json({ id: result.rows[0].id });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not save post.' });
  }
});

app.get('/api/posts/:id/image', async (req, res) => {
  try {
    const result = await pool.query('SELECT image_data, image_type FROM posts WHERE id = $1', [req.params.id]);
    const row = result.rows[0];
    if (!row) return res.status(404).end();
    res.set('Content-Type', row.image_type);
    res.set('Cache-Control', 'public, max-age=31536000, immutable');
    res.send(row.image_data);
  } catch (e) {
    console.error(e);
    res.status(500).end();
  }
});

app.post('/api/posts/:id/like', requireAuth, async (req, res) => {
  try {
    const existing = await pool.query('SELECT 1 FROM likes WHERE user_id = $1 AND post_id = $2', [req.user.id, req.params.id]);
    if (existing.rows.length) {
      await pool.query('DELETE FROM likes WHERE user_id = $1 AND post_id = $2', [req.user.id, req.params.id]);
    } else {
      await pool.query('INSERT INTO likes (user_id, post_id) VALUES ($1, $2)', [req.user.id, req.params.id]);
    }
    const count = await pool.query('SELECT COUNT(*)::int AS n FROM likes WHERE post_id = $1', [req.params.id]);
    res.json({ liked: !existing.rows.length, likes: count.rows[0].n });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not update like.' });
  }
});

// ---- Stories ----

app.post('/api/stories', requireAuth, storyUpload.single('media'), async (req, res) => {
  if (!req.file) return res.status(400).json({ error: 'An image or video is required.' });
  if (!/^image\/|^video\//.test(req.file.mimetype)) {
    return res.status(400).json({ error: 'Only images or videos are allowed.' });
  }
  try {
    const result = await pool.query(
      'INSERT INTO stories (user_id, media_data, media_type) VALUES ($1, $2, $3) RETURNING id',
      [req.user.id, req.file.buffer, req.file.mimetype]
    );
    res.json({ id: result.rows[0].id });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not post story.' });
  }
});

app.get('/api/stories', async (req, res) => {
  const userId = req.user ? req.user.id : 0;
  try {
    await pool.query('DELETE FROM stories WHERE expires_at < now()');
    const result = await pool.query(
      `SELECT u.username, (u.avatar_data IS NOT NULL) AS has_avatar,
              COUNT(s.id)::int AS story_count,
              COUNT(s.id) FILTER (WHERE sv.user_id IS NULL)::int AS unseen_count,
              MIN(s.created_at) AS first_at
       FROM stories s
       JOIN users u ON u.id = s.user_id
       LEFT JOIN story_views sv ON sv.story_id = s.id AND sv.user_id = $1
       GROUP BY u.username, u.avatar_data
       ORDER BY unseen_count DESC, first_at ASC`,
      [userId]
    );
    res.json(result.rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not load stories.' });
  }
});

app.get('/api/stories/:username', async (req, res) => {
  const userId = req.user ? req.user.id : 0;
  try {
    const result = await pool.query(
      `SELECT s.id, s.media_type, s.created_at,
              EXISTS(SELECT 1 FROM story_views WHERE story_id = s.id AND user_id = $1) AS viewed
       FROM stories s
       JOIN users u ON u.id = s.user_id
       WHERE u.username = $2 AND s.expires_at > now()
       ORDER BY s.created_at ASC`,
      [userId, req.params.username]
    );
    res.json(result.rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not load stories.' });
  }
});

app.get('/api/stories/item/:id/media', async (req, res) => {
  try {
    const result = await pool.query('SELECT media_data, media_type FROM stories WHERE id = $1 AND expires_at > now()', [
      req.params.id,
    ]);
    const row = result.rows[0];
    if (!row) return res.status(404).end();
    res.set('Content-Type', row.media_type);
    res.set('Cache-Control', 'public, max-age=3600');
    res.send(row.media_data);
  } catch (e) {
    console.error(e);
    res.status(500).end();
  }
});

app.post('/api/stories/item/:id/view', requireAuth, async (req, res) => {
  try {
    await pool.query('INSERT INTO story_views (user_id, story_id) VALUES ($1, $2) ON CONFLICT DO NOTHING', [
      req.user.id,
      req.params.id,
    ]);
    res.json({ ok: true });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not record view.' });
  }
});

app.delete('/api/stories/item/:id', requireAuth, async (req, res) => {
  try {
    await pool.query('DELETE FROM stories WHERE id = $1 AND user_id = $2', [req.params.id, req.user.id]);
    res.json({ ok: true });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Could not delete story.' });
  }
});

initDb()
  .then(() => {
    app.listen(PORT, () => console.log('Flux backend listening on ' + PORT));
  })
  .catch((e) => {
    console.error('Failed to initialize database:', e);
    process.exit(1);
  });
