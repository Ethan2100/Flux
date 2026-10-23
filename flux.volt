#html
## body { background: #000; color: #fafafa; font-family: -apple-system, Helvetica, Arial, sans-serif; max-width: 420px; margin: 0 auto; padding: 0 0 70px; }
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
## .logo { cursor: pointer; }
## .avatar { overflow: hidden; }
## .avatar img { width: 100%; height: 100%; object-fit: cover; display: block; }
## .avatar .initial { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 14px; color: #fff; }
## .phead .uname, .phead .avatar { cursor: pointer; }
## .profilehead { display: flex; align-items: center; gap: 18px; padding: 20px 16px 10px; }
## .profilehead .avatar { width: 72px; height: 72px; }
## .profilehead .avatar .initial { font-size: 26px; }
## .profileinfo { flex: 1; }
## .profileinfo .uname { font-size: 18px; display: block; margin-bottom: 4px; }
## .profileinfo .bio { font-size: 13px; color: #d7d7d7; }
## .profilemeta { padding: 0 16px 14px; font-size: 13px; color: #a8a8a8; }
## .profileactions { padding: 0 16px 16px; }
## .profileactions button { padding: 8px 16px; background: #262626; color: #fff; border: none; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; }
## .grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 2px; padding: 2px; }
## .grid img { width: 100%; aspect-ratio: 1; object-fit: cover; display: block; background: #111; }
## .backbar { padding: 14px 16px; font-size: 14px; color: #0095f6; cursor: pointer; border-bottom: 1px solid #262626; }
## .settingsrow { padding: 16px; border-bottom: 1px solid #262626; }
## .settingsrow h3 { font-size: 14px; margin: 0 0 10px; }
## .settingsrow label { display: block; font-size: 12px; color: #a8a8a8; margin-bottom: 4px; }
## .settingsrow .ok { color: #2ecc71; font-size: 13px; margin-top: 6px; }
## .avatarpick { display: flex; align-items: center; gap: 14px; margin-bottom: 10px; }
## .avatarpick .avatar { width: 56px; height: 56px; }
## .storiesbar { display: flex; gap: 14px; overflow-x: auto; padding: 14px 16px; border-bottom: 1px solid #262626; }
## .storyitem { flex-shrink: 0; width: 64px; text-align: center; cursor: pointer; }
## .storyring { width: 58px; height: 58px; border-radius: 50%; padding: 2px; margin: 0 auto 4px; background: #333; }
## .storyring.unseen { background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888); }
## .storyring .avatar { width: 100%; height: 100%; border: 2px solid #000; box-sizing: border-box; position: relative; }
## .storyring .plus { position: absolute; bottom: -2px; right: -2px; width: 18px; height: 18px; border-radius: 50%; background: #0095f6; color: #fff; font-size: 13px; line-height: 18px; text-align: center; border: 2px solid #000; }
## .storylabel { font-size: 11px; color: #d7d7d7; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
## .storyviewer { position: fixed; inset: 0; background: #000; z-index: 50; display: flex; flex-direction: column; }
## .sprogress { display: flex; gap: 4px; padding: 8px 8px 0; }
## .sprogress .seg { flex: 1; height: 2px; background: rgba(255,255,255,0.3); border-radius: 2px; overflow: hidden; }
## .sprogress .seg .fill { height: 100%; width: 0%; background: #fff; }
## .sprogress .seg.done .fill { width: 100%; }
## .sheader { display: flex; align-items: center; gap: 10px; padding: 10px 12px; color: #fff; }
## .sheader .avatar { width: 28px; height: 28px; }
## .sheader .suname { font-weight: 600; font-size: 14px; flex: 1; }
## .sheader .sclose { all: unset; cursor: pointer; color: #fff; font-size: 22px; padding: 4px 8px; }
## .smedia { flex: 1; display: flex; align-items: center; justify-content: center; position: relative; overflow: hidden; }
## .smedia img, .smedia video { max-width: 100%; max-height: 100%; }
## .snav { position: absolute; top: 0; bottom: 0; width: 35%; }
## .snav.prev { left: 0; } .snav.next { right: 0; }
## .sempty { color: #a8a8a8; text-align: center; padding: 40px; }
## .bottomnav { position: fixed; bottom: 0; left: 0; right: 0; display: flex; max-width: 420px; margin: 0 auto; background: #000; border-top: 1px solid #262626; z-index: 2; }
## .navbtn { all: unset; flex: 1; text-align: center; padding: 12px 0; cursor: pointer; font-size: 22px; color: #a8a8a8; }
## .navbtn.active { color: #fff; }
## .searchbox { padding: 14px 16px; }
## .searchbox input { width: 100%; box-sizing: border-box; background: #121212; border: 1px solid #333; color: #fff; padding: 10px; border-radius: 8px; font-size: 14px; }
## .searchresult { display: flex; align-items: center; gap: 12px; padding: 10px 16px; cursor: pointer; }
## .searchresult .avatar { width: 44px; height: 44px; border-radius: 50%; flex-shrink: 0; }
## .searchresult .sru { font-weight: 600; font-size: 14px; }
## .searchresult .srb { font-size: 12px; color: #a8a8a8; }
## .profilestats { display: flex; gap: 24px; padding: 0 16px 14px; }
## .profilestats div { font-size: 13px; color: #d7d7d7; }
## .profilestats b { display: block; font-size: 16px; color: #fff; }
## .followbtn { padding: 8px 20px; background: #0095f6; color: #fff; border: none; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; }
## .followbtn.following { background: #262626; }

title "Flux"
html "<div class='bar'><div class='logo' id='logoLink'>Flux</div><div class='who' id='whobox'></div></div>"
html "<div id='app'></div>"

# let me = null
# let view = { type: 'feed' }
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
# function avatarHtml(username, hasAvatar, size) {
#   if (hasAvatar) return `<img src=\"/api/users/${encodeURIComponent(username)}/avatar\" alt=\"\">`
#   const initial = (username || '?').charAt(0).toUpperCase()
#   return `<div class=\"initial\">${esc(initial)}</div>`
# }
#
# function goTo(next) {
#   view = next
#   renderApp()
#   window.scrollTo(0, 0)
# }
#
# function renderWho() {
#   const box = document.getElementById('whobox')
#   if (me) {
#     box.innerHTML = `
#       <div class=\"avatar\" id=\"whoAvatar\" style=\"width:28px;height:28px;border-radius:50%\">${avatarHtml(me.username, me.has_avatar)}</div>
#       <button id=\"settingsBtn\">Settings</button>
#       <button id=\"logoutBtn\">Log out</button>
#     `
#     document.getElementById('whoAvatar').onclick = () => goTo({ type: 'profile', username: me.username })
#     document.getElementById('settingsBtn').onclick = () => goTo({ type: 'settings' })
#     document.getElementById('logoutBtn').onclick = async () => {
#       await api('/api/logout', { method: 'POST' })
#       me = null
#       renderWho()
#       goTo({ type: 'feed' })
#     }
#   } else {
#     box.innerHTML = '<button id=\"loginBtn\">Log in / Sign up</button>'
#     document.getElementById('loginBtn').onclick = () => goTo({ type: 'auth', mode: 'login' })
#   }
# }
#
# function renderAuth(container, mode) {
#   const isLogin = mode !== 'signup'
#   const box = document.createElement('div')
#   box.className = 'authbox'
#   box.innerHTML = `
#     <h3>${isLogin ? 'Log in' : 'Sign up'}</h3>
#     <input id='authUser' type='text' placeholder='Username' autocomplete='username'>
#     <input id='authPass' type='password' placeholder='Password' autocomplete='${isLogin ? 'current-password' : 'new-password'}'>
#     <button id='authSubmit'>${isLogin ? 'Log in' : 'Sign up'}</button>
#     <div class='error' id='authError'></div>
#     <div class='switchline'>${isLogin ? "No account? <a id='switchLink'>Sign up</a>" : "Have an account? <a id='switchLink'>Log in</a>"}</div>
#   `
#   container.appendChild(box)
#   document.getElementById('switchLink').onclick = () => goTo({ type: 'auth', mode: isLogin ? 'signup' : 'login' })
#   document.getElementById('authSubmit').onclick = async () => {
#     const username = document.getElementById('authUser').value.trim()
#     const password = document.getElementById('authPass').value
#     const errEl = document.getElementById('authError')
#     errEl.textContent = ''
#     try {
#       me = await api(isLogin ? '/api/login' : '/api/signup', { method: 'POST', body: JSON.stringify({ username, password }) })
#       renderWho()
#       goTo({ type: 'feed' })
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
#       renderApp()
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
#     <div class='phead'>
#       <div class='avatar' id='pav${p.id}' style='width:32px;height:32px;border-radius:50%'>${avatarHtml(p.username, p.has_avatar)}</div>
#       <div class='uname' id='pun${p.id}'>${esc(p.username)}</div>
#     </div>
#     <img class='photo' src='/api/posts/${p.id}/image' loading='lazy'>
#     <div class='actions'><button class='likebtn${likedClass}' id='like${p.id}'>${heart}</button></div>
#     <div class='likes' id='likes${p.id}'>${p.likes} likes</div>
#     <div class='caption'><b>${esc(p.username)}</b>${esc(p.caption)}</div>
#   `
#   const goProfile = () => goTo({ type: 'profile', username: p.username })
#   el.querySelector('#pav' + p.id).onclick = goProfile
#   el.querySelector('#pun' + p.id).onclick = goProfile
#   el.querySelector('#like' + p.id).onclick = async () => {
#     if (!me) { goTo({ type: 'auth', mode: 'login' }); return }
#     const btn = el.querySelector('#like' + p.id)
#     const result = await api('/api/posts/' + p.id + '/like', { method: 'POST' })
#     btn.classList.toggle('liked', result.liked)
#     btn.innerHTML = result.liked ? '&#10084;' : '&#9825;'
#     el.querySelector('#likes' + p.id).textContent = result.likes + ' likes'
#   }
#   return el
# }
#
# async function uploadStory(file) {
#   const form = new FormData()
#   form.append('media', file)
#   const res = await fetch('/api/stories', { method: 'POST', body: form })
#   if (!res.ok) { const d = await res.json().catch(() => ({})); throw new Error(d.error || 'Could not post story.') }
# }
#
# function openStoryUploadPicker(onDone) {
#   const input = document.createElement('input')
#   input.type = 'file'
#   input.accept = 'image/*,video/*'
#   input.onchange = async () => {
#     if (!input.files[0]) return
#     try {
#       await uploadStory(input.files[0])
#       onDone && onDone()
#     } catch (e) {
#       alert(e.message)
#     }
#   }
#   input.click()
# }
#
# async function openStoryViewer(username) {
#   let items
#   try {
#     items = await api('/api/stories/' + encodeURIComponent(username))
#   } catch (e) {
#     items = []
#   }
#   if (!items.length) return
#
#   const overlay = document.createElement('div')
#   overlay.className = 'storyviewer'
#   overlay.innerHTML = `
#     <div class='sprogress' id='sprogress'></div>
#     <div class='sheader'>
#       <div class='avatar' id='sheadAvatar'></div>
#       <div class='suname'>${esc(username)}</div>
#       <button class='sclose' id='sclose'>&times;</button>
#     </div>
#     <div class='smedia' id='smedia'>
#       <div class='snav prev' id='snavPrev'></div>
#       <div class='snav next' id='snavNext'></div>
#     </div>
#   `
#   document.body.appendChild(overlay)
#   document.getElementById('sheadAvatar').innerHTML = avatarHtml(username, (me && me.username === username) ? me.has_avatar : true)
#
#   const progBar = document.getElementById('sprogress')
#   items.forEach(() => {
#     const seg = document.createElement('div')
#     seg.className = 'seg'
#     seg.innerHTML = '<div class=\"fill\"></div>'
#     progBar.appendChild(seg)
#   })
#
#   let idx = 0
#   let timer = null
#
#   function close() {
#     if (timer) clearTimeout(timer)
#     overlay.remove()
#   }
#
#   async function show(i) {
#     if (i < 0) { close(); return }
#     if (i >= items.length) { close(); return }
#     idx = i
#     const segs = progBar.querySelectorAll('.seg')
#     segs.forEach((s, j) => { s.classList.toggle('done', j < idx) })
#     const media = document.getElementById('smedia')
#     media.querySelectorAll('img, video').forEach((el) => el.remove())
#     const item = items[idx]
#     api('/api/stories/item/' + item.id + '/view', { method: 'POST' }).catch(() => {})
#     if (item.media_type.startsWith('video/')) {
#       const vid = document.createElement('video')
#       vid.src = '/api/stories/item/' + item.id + '/media'
#       vid.autoplay = true
#       vid.muted = true
#       vid.playsInline = true
#       vid.onended = () => show(idx + 1)
#       media.insertBefore(vid, document.getElementById('snavPrev'))
#       segs[idx].classList.add('done')
#     } else {
#       const img = document.createElement('img')
#       img.src = '/api/stories/item/' + item.id + '/media'
#       media.insertBefore(img, document.getElementById('snavPrev'))
#       if (timer) clearTimeout(timer)
#       timer = setTimeout(() => show(idx + 1), 5000)
#       segs[idx].classList.add('done')
#     }
#   }
#
#   document.getElementById('sclose').onclick = close
#   document.getElementById('snavPrev').onclick = () => show(idx - 1)
#   document.getElementById('snavNext').onclick = () => show(idx + 1)
#   show(0)
# }
#
# async function renderStoriesBar(app) {
#   let people = []
#   try { people = await api('/api/stories') } catch (e) {}
#   const bar = document.createElement('div')
#   bar.className = 'storiesbar'
#
#   if (me) {
#     const mine = people.find((p) => p.username === me.username)
#     const item = document.createElement('div')
#     item.className = 'storyitem'
#     item.innerHTML = `
#       <div class='storyring${mine && mine.unseen_count > 0 ? ' unseen' : ''}'>
#         <div class='avatar' style='border-radius:50%'>${avatarHtml(me.username, me.has_avatar)}${!mine ? "<div class='plus'>+</div>" : ''}</div>
#       </div>
#       <div class='storylabel'>Your story</div>
#     `
#     item.onclick = () => {
#       if (mine) openStoryViewer(me.username)
#       else openStoryUploadPicker(() => goTo(view))
#     }
#     bar.appendChild(item)
#   }
#
#   people.filter((p) => !me || p.username !== me.username).forEach((p) => {
#     const item = document.createElement('div')
#     item.className = 'storyitem'
#     item.innerHTML = `
#       <div class='storyring${p.unseen_count > 0 ? ' unseen' : ''}'>
#         <div class='avatar' style='border-radius:50%'>${avatarHtml(p.username, p.has_avatar)}</div>
#       </div>
#       <div class='storylabel'>${esc(p.username)}</div>
#     `
#     item.onclick = () => openStoryViewer(p.username)
#     bar.appendChild(item)
#   })
#
#   if (bar.children.length) app.appendChild(bar)
# }
#
# async function renderFeedView(app) {
#   await renderStoriesBar(app)
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
# async function renderProfileView(app, username) {
#   const back = document.createElement('div')
#   back.className = 'backbar'
#   back.textContent = '< Back to feed'
#   back.onclick = () => goTo({ type: 'feed' })
#   app.appendChild(back)
#
#   let profile
#   try {
#     profile = await api('/api/users/' + encodeURIComponent(username))
#   } catch (e) {
#     const empty = document.createElement('div')
#     empty.className = 'empty'
#     empty.textContent = 'User not found.'
#     app.appendChild(empty)
#     return
#   }
#
#   const head = document.createElement('div')
#   head.className = 'profilehead'
#   head.innerHTML = `
#     <div class='avatar'>${avatarHtml(profile.username, profile.has_avatar)}</div>
#     <div class='profileinfo'>
#       <span class='uname'>${esc(profile.username)}</span>
#       <div class='bio'>${esc(profile.bio || '')}</div>
#     </div>
#   `
#   app.appendChild(head)
#
#   const stats = document.createElement('div')
#   stats.className = 'profilestats'
#   stats.innerHTML = `
#     <div><b>${profile.post_count}</b>${profile.post_count === 1 ? 'post' : 'posts'}</div>
#     <div><b>${profile.follower_count}</b>followers</div>
#     <div><b>${profile.following_count}</b>following</div>
#   `
#   app.appendChild(stats)
#
#   const actions = document.createElement('div')
#   actions.className = 'profileactions'
#   if (me && me.username === profile.username) {
#     actions.innerHTML = `<button id='editProfileBtn'>Edit profile</button>`
#     app.appendChild(actions)
#     document.getElementById('editProfileBtn').onclick = () => goTo({ type: 'settings' })
#   } else if (me) {
#     actions.innerHTML = `<button class='followbtn${profile.is_following ? ' following' : ''}' id='followBtn'>${profile.is_following ? 'Following' : 'Follow'}</button>`
#     app.appendChild(actions)
#     document.getElementById('followBtn').onclick = async () => {
#       const btn = document.getElementById('followBtn')
#       const result = await api('/api/users/' + encodeURIComponent(profile.username) + '/follow', { method: 'POST' })
#       btn.textContent = result.following ? 'Following' : 'Follow'
#       btn.classList.toggle('following', result.following)
#       stats.innerHTML = `
#         <div><b>${profile.post_count}</b>${profile.post_count === 1 ? 'post' : 'posts'}</div>
#         <div><b>${result.follower_count}</b>followers</div>
#         <div><b>${profile.following_count}</b>following</div>
#       `
#     }
#   }
#
#   const posts = await api('/api/users/' + encodeURIComponent(username) + '/posts')
#   if (!posts.length) {
#     const empty = document.createElement('div')
#     empty.className = 'empty'
#     empty.textContent = 'No posts yet.'
#     app.appendChild(empty)
#     return
#   }
#   const grid = document.createElement('div')
#   grid.className = 'grid'
#   posts.forEach((p) => {
#     const img = document.createElement('img')
#     img.src = '/api/posts/' + p.id + '/image'
#     img.loading = 'lazy'
#     grid.appendChild(img)
#   })
#   app.appendChild(grid)
# }
#
# function renderSettingsView(app) {
#   const back = document.createElement('div')
#   back.className = 'backbar'
#   back.textContent = '< Back'
#   back.onclick = () => goTo({ type: 'profile', username: me.username })
#   app.appendChild(back)
#
#   const avatarRow = document.createElement('div')
#   avatarRow.className = 'settingsrow'
#   avatarRow.innerHTML = `
#     <h3>Profile photo</h3>
#     <div class='avatarpick'>
#       <div class='avatar' id='avatarPreview'>${avatarHtml(me.username, me.has_avatar)}</div>
#       <input id='avatarFile' type='file' accept='image/*'>
#     </div>
#     <button id='avatarSave'>Save photo</button>
#     <div class='error' id='avatarError'></div>
#   `
#   app.appendChild(avatarRow)
#   document.getElementById('avatarSave').onclick = async () => {
#     const fileInput = document.getElementById('avatarFile')
#     const errEl = document.getElementById('avatarError')
#     errEl.textContent = ''
#     if (!fileInput.files[0]) { errEl.textContent = 'Pick an image first.'; return }
#     const form = new FormData()
#     form.append('avatar', fileInput.files[0])
#     try {
#       const res = await fetch('/api/me/avatar', { method: 'POST', body: form })
#       if (!res.ok) { const d = await res.json().catch(() => ({})); throw new Error(d.error || 'Could not save.') }
#       me.has_avatar = true
#       renderWho()
#       goTo({ type: 'settings' })
#     } catch (e) {
#       errEl.textContent = e.message
#     }
#   }
#
#   const profileRow = document.createElement('div')
#   profileRow.className = 'settingsrow'
#   profileRow.innerHTML = `
#     <h3>Profile info</h3>
#     <label>Username</label>
#     <input id='editUsername' type='text' value='${esc(me.username)}'>
#     <label>Bio</label>
#     <input id='editBio' type='text' value='${esc(me.bio || '')}' maxlength='150'>
#     <button id='profileSave'>Save changes</button>
#     <div class='error' id='profileError'></div>
#     <div class='ok' id='profileOk'></div>
#   `
#   app.appendChild(profileRow)
#   document.getElementById('profileSave').onclick = async () => {
#     const username = document.getElementById('editUsername').value.trim()
#     const bio = document.getElementById('editBio').value
#     const errEl = document.getElementById('profileError')
#     const okEl = document.getElementById('profileOk')
#     errEl.textContent = ''
#     okEl.textContent = ''
#     try {
#       me = await api('/api/me', { method: 'PATCH', body: JSON.stringify({ username, bio }) })
#       renderWho()
#       okEl.textContent = 'Saved.'
#     } catch (e) {
#       errEl.textContent = e.message
#     }
#   }
#
#   const passRow = document.createElement('div')
#   passRow.className = 'settingsrow'
#   passRow.innerHTML = `
#     <h3>Change password</h3>
#     <label>Current password</label>
#     <input id='curPass' type='password'>
#     <label>New password</label>
#     <input id='newPass' type='password'>
#     <button id='passSave'>Update password</button>
#     <div class='error' id='passError'></div>
#     <div class='ok' id='passOk'></div>
#   `
#   app.appendChild(passRow)
#   document.getElementById('passSave').onclick = async () => {
#     const currentPassword = document.getElementById('curPass').value
#     const newPassword = document.getElementById('newPass').value
#     const errEl = document.getElementById('passError')
#     const okEl = document.getElementById('passOk')
#     errEl.textContent = ''
#     okEl.textContent = ''
#     try {
#       await api('/api/me/password', { method: 'POST', body: JSON.stringify({ currentPassword, newPassword }) })
#       document.getElementById('curPass').value = ''
#       document.getElementById('newPass').value = ''
#       okEl.textContent = 'Password updated.'
#     } catch (e) {
#       errEl.textContent = e.message
#     }
#   }
# }
#
# function renderSearchView(app) {
#   const box = document.createElement('div')
#   box.className = 'searchbox'
#   box.innerHTML = `<input id='searchInput' type='text' placeholder='Search users'>`
#   app.appendChild(box)
#   const results = document.createElement('div')
#   results.id = 'searchResults'
#   app.appendChild(results)
#
#   let t = null
#   document.getElementById('searchInput').oninput = (e) => {
#     if (t) clearTimeout(t)
#     const q = e.target.value.trim()
#     t = setTimeout(async () => {
#       results.innerHTML = ''
#       if (!q) return
#       const users = await api('/api/search/users?q=' + encodeURIComponent(q))
#       if (!users.length) {
#         results.innerHTML = "<div class='empty'>No users found.</div>"
#         return
#       }
#       users.forEach((u) => {
#         const row = document.createElement('div')
#         row.className = 'searchresult'
#         row.innerHTML = `
#           <div class='avatar' style='border-radius:50%'>${avatarHtml(u.username, u.has_avatar)}</div>
#           <div><div class='sru'>${esc(u.username)}</div><div class='srb'>${esc(u.bio || '')}</div></div>
#         `
#         row.onclick = () => goTo({ type: 'profile', username: u.username })
#         results.appendChild(row)
#       })
#     }, 250)
#   }
#   document.getElementById('searchInput').focus()
# }
#
# function renderBottomNav() {
#   let nav = document.getElementById('bottomnav')
#   if (!nav) {
#     nav = document.createElement('div')
#     nav.id = 'bottomnav'
#     nav.className = 'bottomnav'
#     nav.innerHTML = `
#       <button class='navbtn' id='navHome'>&#8962;</button>
#       <button class='navbtn' id='navSearch'>&#128269;</button>
#       <button class='navbtn' id='navProfile'>&#128100;</button>
#     `
#     document.body.appendChild(nav)
#     document.getElementById('navHome').onclick = () => goTo({ type: 'feed' })
#     document.getElementById('navSearch').onclick = () => goTo({ type: 'search' })
#     document.getElementById('navProfile').onclick = () => {
#       if (me) goTo({ type: 'profile', username: me.username })
#       else goTo({ type: 'auth', mode: 'login' })
#     }
#   }
#   const map = { feed: 'navHome', search: 'navSearch', profile: 'navProfile' }
#   nav.querySelectorAll('.navbtn').forEach((b) => b.classList.remove('active'))
#   const activeId = map[view.type]
#   if (activeId) document.getElementById(activeId).classList.add('active')
# }
#
# async function renderApp() {
#   const app = document.getElementById('app')
#   app.innerHTML = ''
#   renderBottomNav()
#   if (view.type === 'auth') { renderAuth(app, view.mode); return }
#   if (view.type === 'settings') {
#     if (!me) { goTo({ type: 'auth', mode: 'login' }); return }
#     renderSettingsView(app)
#     return
#   }
#   if (view.type === 'search') { renderSearchView(app); return }
#   if (view.type === 'profile') { renderProfileView(app, view.username); return }
#   renderFeedView(app)
# }
#
# async function init() {
#   me = await api('/api/me')
#   renderWho()
#   document.getElementById('logoLink').onclick = () => goTo({ type: 'feed' })
#   renderApp()
# }
# init()
