
" Indentation settings
set expandtab
set softtabstop=4
set shiftwidth=4
set smartindent
set incsearch
set number
" gvim setting go here
set guifont=Mono\ 12
" enable matchit plugin
:filetype plugin on
" map F3 to Taglist toggle command
map <F3> :TlistToggle<CR>
"set dictionary to look up
set dictionary+=/usr/share/dict/words
"set t_Co to specify color sheme
set t_Co=256
let g:molokai_original = 1
colorscheme molokai
" set informative tab line
set showtabline=2
set tabpagemax=20
nnoremap tg :tabp<CR>
nnoremap lt :tabs<CR>
" set cursor line and specify its background color
set cursorline
highlight CursorLine guibg=darkgray ctermbg=darkgray
"modify key binding
imap ii <Esc>:w<CR>
map <F4>q <Esc>:wqa<CR>
imap <F4>q <Esc>:wqa<CR>
map <F4>w <Esc>:w<CR>
imap <F4>w <Esc>:w<CR>
map <F4>c <Esc>:bd!<CR>
"map ant deploy-js && ant deploy-xhtml command
map <F3>j :w<CR>:!cd $SF_HOME && ant deploy-js<CR>
map <F3>x :w<CR>:!cd $SF_HOME && ant deploy-xhtml<CR>
map <F3>c :w<CR>:!cd $SF_HOME && ant deploy-css<CR>
map <F3>p :w<CR>:!cd $SF_HOME && ant deploy-jsp<CR>
map <F3>a :w<CR>:!cd $SF_HOME && ant deploy-css deploy-js deploy-xhtml deploy-jsp<CR>
map <F3>m :w<CR>:!cp -r ~/workspace/hmp.git/src/main/webapp/ui/homepage/ ~/workspace/v4.git/web/ui && cd $SF_HOME && ant deploy-css deploy-js deploy-xhtml<CR>
"setting for getfiles plugin (getfiles.vim)
let g:GetFileIgnoreList = ['*.jpg','*.png','*.gif','*.class','*.jar','*.zip','*/tmp/*','*/bin/*','*/build/*','*/.svn/*','*/settings/*','*/test/*','*/build_resources/*','*/target/*']
let g:GetFileAutoFillFolder = 2
imap <F4>i <Esc>:GetFileCacheFiles<CR>
map <F4>i <Esc>:GetFileCacheFiles<CR>
imap <F4>f <Esc>:w<CR>:GetFile<CR>
map <F4>f <Esc>:w<CR>:GetFile<CR>
map <F4>g <Esc>:lcd %:p:h<CR>
""map <C-n> <Esc>:bn<CR>
""imap <C-n> <Esc>:bn<CR>
""map <C-p> <Esc>:bp<CR>
""imap <C-p> <Esc>:bp<CR>
" insert new line under command mode
map <CR> o<Esc>
"" map Ctrl-shift-c to copy all content of current buffer to clipboard
noremap <c-c> <Esc>ggVG"+y
