# Flux

A real, working Instagram-style app: accounts, a Postgres database, real image
uploads, and likes that persist and are shared across everyone who visits.

The frontend (`flux.volt`, compiled to `public/index.html`) is written in
Volt. The backend (`server.js`) is plain Node/Express with a Postgres
database — Volt has no concept of routes, logins, or databases, so that part
genuinely isn't "Volt code," it's a normal server the Volt page talks to.

## Deploying to Render

1. Get this code into a GitHub repository (create a new repo on github.com,
   then upload these files, or push from your own machine with git).
2. On Render: **New** → **Blueprint**, and connect that GitHub repo.
3. Render reads `render.yaml` automatically and sets up two things:
   - A free Postgres database (`flux-db`)
   - A free web service (`flux`) running this app
   It also generates `JWT_SECRET` and wires `DATABASE_URL` for you — nothing
   to fill in by hand.
4. Click **Apply** / **Deploy**. After a couple of minutes you'll get a live
   URL (something like `flux.onrender.com`) that works for anyone,
   not just you.

## Running it locally first (optional)

```
npm install
# needs a Postgres database - set DATABASE_URL to point at one
DATABASE_URL="postgres://user:pass@localhost:5432/flux" JWT_SECRET="anything" npm start
```

Then open http://localhost:3000.

## Known limits of the free Render tier

- The free database holds **1 GB**, which is a lot of text/rows but will
  fill up eventually if everyone keeps uploading full-size photos — worth
  knowing, not an immediate problem.
- Render's free web service **spins down after 15 minutes of no traffic**
  and takes maybe 30-60 seconds to wake back up on the next visit. That's a
  real tradeoff of free hosting, not a bug.
- Uploaded images are capped at **5MB** each (set in `server.js`, search for
  `fileSize`) — raise it there if you need bigger photos.

## Editing the frontend

Change `flux.volt`, then recompile it and copy the result into `public/`:

```
node /path/to/volt-studio/compiler/volt.js flux.volt
cp flux/index.html public/index.html
```
(Or just open `flux.volt` in Volt Studio — Volt Studio's compile step
does the same thing.)
