#html
## body { background: #000; color: #fafafa; font-family: -apple-system, Helvetica, Arial, sans-serif; max-width: 420px; margin: 0 auto; padding: 0 0 40px; }
## h1 { display: none; }
## .bar { display: flex; align-items: center; justify-content: space-between; padding: 14px 16px; border-bottom: 1px solid #262626; position: sticky; top: 0; background: #000; z-index: 1; }
## .bar .logo { font-size: 24px; font-weight: 700; font-family: cursive; }
## .bar .who { font-size: 13px; color: #a8a8a8; display: flex; align-items: center; gap: 10px; }
## .bar .who button { all: unset; cursor: pointer; color: #0095f6; font-size: 13px; font-weight: 600; }
## .post { border-bottom: 1px solid #262626; margin-bottom: 8px; }
## .phead { display: flex; align-items: center; gap: 10px; padding: 10px 12px; }
## .avatar { width: 32px; height: 32px; border-radius: 50%; background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888); flex-shrink: 0; }
## .uname { font-weight: 600; font-size: 14px; }
## .photo { width: 100%; display: block; background: #111; aspect-ratio: 1; object-fit: cover; }
## .actions { padding: 8px 12px 0; }
## button.likebtn { all: unset; cursor: pointer; display: inline; font-size: 26px; color: #fafafa; padding: 4px 8px 4px 0; }
## button.likebtn.liked { color: #ed4956; }
## .likes { font-weight: 600; font-size: 14px; padding: 4px 12px; }
## .caption { font-size: 14px; padding: 2px 12px 12px; }
## .caption b { margin-right: 6px; }
## .authbox, .composer { padding: 20px 16px; }
## .authbox input, .composer input[type=text] { width: 100%; box-sizing: border-box; background: #121212; border: 1px solid #333; color: #fff; padding: 10px; border-radius: 6px; margin-bottom: 10px; font-size: 14px; }
## .authbox button, .composer button.primary { width: 100%; padding: 12px; background: #0095f6; color: #fff; border: none; border-radius: 8px; font-weight: 600; font-size: 14px; cursor: pointer; margin-top: 4px; }
## .switchline { text-align: center; font-size: 13px; color: #a8a8a8; margin-top: 14px; }
## .switchline a { color: #0095f6; cursor: pointer; }
## .error { color: #ed4956; font-size: 13px; margin-top: 6px; }
## .composer { border-bottom: 1px solid #262626; }
## .composer h3 { font-size: 15px; margin: 0 0 10px; }
## .empty { padding: 40px 16px; text-align: center; color: #a8a8a8; font-size: 14px; }

title "Flux"
html "<div class='bar'><div class='logo'>Flux</div><div class='who' id='whobox'></div></div>"
html "<div id='app'></div>"

# let me = null
#
# async function api(url, opts) {
#   const res = await fetch(url, Object.assign({ headers: { 'content-type': 'application/json' } }, opts))
#   let data = null
#   try { data = await res.json() } catch (e) {}
#   if (!res.ok) throw new Error((data && data.error) || 'Something went wrong')
#   return data
# }
#
# function esc(s) {
#   const d = document.createElement('div')
#   d.textContent = s == null ? '' : s
#   return d.innerHTML
# }
#
# function renderWho() {
#   const box = document.getElementById('whobox')
#   if (me) {
#     box.innerHTML = '<span>' + esc(me.username) + '</span><button id=\"logoutBtn\">Log out</button>'
#     document.getElementById('logoutBtn').onclick = async () => {
#       await api('/api/logout', { method: 'POST' })
#       me = null
#       renderWho()
#       renderApp()
#     }
#   } else {
#     box.innerHTML = '<button id=\"loginBtn\">Log in / Sign up</button>'
#     document.getElementById('loginBtn').onclick = () => renderAuth('login')
#   }
# }
#
# function renderAuth(mode) {
#   const app = document.getElementById('app')
#   const isLogin = mode !== 'signup'
#   app.innerHTML = `
#     <div class='authbox'>
#       <h3>${isLogin ? 'Log in' : 'Sign up'}</h3>
#       <input id='authUser' type='text' placeholder='Username' autocomplete='username'>
#       <input id='authPass' type='password' placeholder='Password' autocomplete='${isLogin ? 'current-password' : 'new-password'}'>
#       <button id='authSubmit'>${isLogin ? 'Log in' : 'Sign up'}</button>
#       <div class='error' id='authError'></div>
#       <div class='switchline'>${isLogin ? "No account? <a id='switchLink'>Sign up</a>" : "Have an account? <a id='switchLink'>Log in</a>"}</div>
#     </div>
#   `
#   document.getElementById('switchLink').onclick = () => renderAuth(isLogin ? 'signup' : 'login')
#   document.getElementById('authSubmit').onclick = async () => {
#     const username = document.getElementById('authUser').value.trim()
#     const password = document.getElementById('authPass').value
#     const errEl = document.getElementById('authError')
#     errEl.textContent = ''
#     try {
#       me = await api(isLogin ? '/api/login' : '/api/signup', { method: 'POST', body: JSON.stringify({ username, password }) })
#       renderWho()
#       renderApp()
#     } catch (e) {
#       errEl.textContent = e.message
#     }
#   }
# }
#
# function renderComposer(container) {
#   const box = document.createElement('div')
#   box.className = 'composer'
#   box.innerHTML = `
#     <h3>New post</h3>
#     <input id='composerFile' type='file' accept='image/*'>
#     <input id='composerCaption' type='text' placeholder='Write a caption...'>
#     <button class='primary' id='composerSubmit'>Share</button>
#     <div class='error' id='composerError'></div>
#   `
#   container.appendChild(box)
#   document.getElementById('composerSubmit').onclick = async () => {
#     const fileInput = document.getElementById('composerFile')
#     const errEl = document.getElementById('composerError')
#     errEl.textContent = ''
#     if (!fileInput.files[0]) { errEl.textContent = 'Pick an image first.'; return }
#     const form = new FormData()
#     form.append('image', fileInput.files[0])
#     form.append('caption', document.getElementById('composerCaption').value)
#     try {
#       await fetch('/api/posts', { method: 'POST', body: form }).then(async (res) => {
#         if (!res.ok) { const d = await res.json().catch(() => ({})); throw new Error(d.error || 'Could not post.') }
#       })
#       await loadFeed()
#     } catch (e) {
#       errEl.textContent = e.message
#     }
#   }
# }
#
# function renderPost(p) {
#   const el = document.createElement('div')
#   el.className = 'post'
#   const heart = p.liked_by_me ? '&#10084;' : '&#9825;'
#   const likedClass = p.liked_by_me ? ' liked' : ''
#   el.innerHTML = `
#     <div class='phead'><div class='avatar'></div><div class='uname'>${esc(p.username)}</div></div>
#     <img class='photo' src='/api/posts/${p.id}/image' loading='lazy'>
#     <div class='actions'><button class='likebtn${likedClass}' id='like${p.id}'>${heart}</button></div>
#     <div class='likes' id='likes${p.id}'>${p.likes} likes</div>
#     <div class='caption'><b>${esc(p.username)}</b>${esc(p.caption)}</div>
#   `
#   el.querySelector('#like' + p.id).onclick = async () => {
#     if (!me) { renderAuth('login'); return }
#     const btn = el.querySelector('#like' + p.id)
#     const result = await api('/api/posts/' + p.id + '/like', { method: 'POST' })
#     btn.classList.toggle('liked', result.liked)
#     btn.innerHTML = result.liked ? '&#10084;' : '&#9825;'
#     el.querySelector('#likes' + p.id).textContent = result.likes + ' likes'
#   }
#   return el
# }
#
# async function loadFeed() {
#   const app = document.getElementById('app')
#   app.innerHTML = ''
#   if (me) renderComposer(app)
#   const posts = await api('/api/posts')
#   if (!posts.length) {
#     const empty = document.createElement('div')
#     empty.className = 'empty'
#     empty.textContent = 'No posts yet. Be the first to share something!'
#     app.appendChild(empty)
#     return
#   }
#   posts.forEach((p) => app.appendChild(renderPost(p)))
# }
#
# function renderApp() {
#   loadFeed()
# }
#
# async function init() {
#   me = await api('/api/me')
#   renderWho()
#   renderApp()
# }
# init()
