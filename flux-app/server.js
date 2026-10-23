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

const pool = new Pool({
  connectionString: DATABASE_URL,
  // Render's internal DB URL doesn't need SSL; the external one does.
  ssl: DATABASE_URL.includes('render.com') && !DATABASE_URL.includes('internal')
    ? { rejectUnauthorized: false }
    : false,
});

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
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

// ---- Auth routes ----

app.post('/api/signup', async (req, res) => {
  const { username, password } = req.body || {};
  if (!username || !password || username.length < 3 || password.length < 4) {
    return res.status(400).json({ error: 'Username (3+ chars) and password (4+ chars) required.' });
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

app.get('/api/me', (req, res) => {
  res.json(req.user ? { id: req.user.id, username: req.user.username } : null);
});

// ---- Posts routes ----

app.get('/api/posts', async (req, res) => {
  const userId = req.user ? req.user.id : 0;
  try {
    const result = await pool.query(
      `SELECT p.id, p.caption, p.created_at, u.username,
              COUNT(l.user_id)::int AS likes,
              COALESCE(BOOL_OR(l.user_id = $1), false) AS liked_by_me
       FROM posts p
       JOIN users u ON u.id = p.user_id
       LEFT JOIN likes l ON l.post_id = p.id
       GROUP BY p.id, u.username
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

initDb()
  .then(() => {
    app.listen(PORT, () => console.log('Flux backend listening on ' + PORT));
  })
  .catch((e) => {
    console.error('Failed to initialize database:', e);
    process.exit(1);
  });
