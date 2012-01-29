" customized setting goes here
" Indentation settings
set expandtab
set softtabstop=4
set shiftwidth=4
set smartindent
set incsearch
set number
" enable matchit plugin
:filetype plugin on
" map F2 to NERDTreeToggle command
map <F2> :NERDTreeToggle<CR>
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
"setting for getfiles plugin (getfiles.vim)
let g:cwdir = "~/workspace/v4.git"
let g:GetFileIgnoreList = ['*.jpg','*.png','*.gif','*.class','*.jar','*.zip','*/tmp/*','*/bin/*','*/build/*','*/.svn/*','*/settings/*','*/test/*']
let g:GetFileAutoFillFolder = 2
imap <F4>i <Esc>:exe "GetFileCacheFiles " g:cwdir<CR>
map <F4>i <Esc>: exe "GetFileCacheFiles " g:cwdir<CR>
imap <F4>f <Esc>:w<CR>:GetFile<CR>
map <F4>f <Esc>:w<CR>:GetFile<CR>
map <F4>g <Esc>:lcd %:p:h<CR>
""map <C-n> <Esc>:bn<CR>
""imap <C-n> <Esc>:bn<CR>
""map <C-p> <Esc>:bp<CR>
""imap <C-p> <Esc>:bp<CR>
