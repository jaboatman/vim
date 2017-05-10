" execute pathogen#infect()

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'
" :PluginInstall
Plugin 'JuliaEditorSupport/julia-vim'
" Do this from vim? Or in here?
" :PluginInstall!
Plugin 'scrooloose/nerdtree'
" Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'jistr/vim-nerdtree-tabs'

Plugin 'mkitt/tabline.vim'

Plugin 'rust-lang/rust.vim'

Plugin 'Valloric/YouCompleteMe'



call vundle#end()
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
set ttyfast

let mapleader = ','

nore <leader>r <ESC>:NERDTreeTabsToggle<CR>

let g:nerdtree_tabs_open_on_console_startup=1

map <F7> :tabp <Enter>
map <F8> :tabn <Enter>

map - <C-W>-
map = <C-W>+

map _ <C-W><
map + <C-W>>

autocmd FileType make,go setlocal noexpandtab

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_global_default.py'
let g:ycm_confirm_extra_conf = 0

let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.16.0-src/src'

" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>


let NERDTreeIgnore=['\.o$', '\.gcda$', '\.gcno$']
  
autocmd BufNewFile,BufRead *.rs set filetype=rust
autocmd BufNewFile,BufRead *.jl set filetype=julia

