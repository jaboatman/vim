execute pathogen#infect()
syntax on
filetype plugin indent on
set t_Co=256
colorscheme molokai
set autoindent
set tabstop=2
set shiftwidth=2
set cindent
set expandtab
set cc=100
set nu

let mapleader = ','

nore <leader>r <ESC>:NERDTree<CR>

let g:nerdtree_tabs_open_on_console_startup=1

map <F7> :tabp <Enter>
map <F8> :tabn <Enter>

map - <C-W>-
map = <C-W>+

map _ <C-W><
map + <C-W>>

function! GetUnixSeconds()
  let t = system("date +%s")
  return strpart(t, 0, strlen(t)-1)
endfunction

function GetMkSessionName()
  let t = GetUnixSeconds()
  return ".vimsession" . t . ".vim"
endfunction

function CreateVimSession()
  let t = GetMkSessionName()
  execute "mksession " . t
endfunction

function LoadSession()
  let f = split(globpath('.', '.vimsession*'), '\n')
  call map(f, strpart('(v:val)', strlen('.vimsession'), strlen('(v:val)') - strlen('.vimsession')))
  echo f
endfunction

map <F5> :call CreateVimSession() <Enter>
  

autocmd FileType make setlocal noexpandtab
autocmd FileType go setlocal noexpandtab

let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_use_library = 1
let g:clang_close_preview = 1
let g:clang_user_options = '-std=c++11'

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>


let NERDTreeIgnore=['\.o$', '\.gcda$', '\.gcno$']
