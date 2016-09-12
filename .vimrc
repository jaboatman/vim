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

map <F7> :tabp <Enter>
map <F8> :tabn <Enter>

autocmd FileType make setlocal noexpandtab
autocmd FileType go setlocal noexpandtab

let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_use_library = 1
