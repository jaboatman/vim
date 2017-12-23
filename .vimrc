" execute pathogen#infect()

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
" :PluginInstall

Plugin 'VundleVim/Vundle.vim'

if !has('nvim')
  Plugin 'tpope/vim-sensible'
endif
Plugin 'tpope/vim-fugitive'

Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'mkitt/tabline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'JuliaEditorSupport/julia-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

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

map <F7> :tabp <Enter>
map <F8> :tabn <Enter>

" map - <C-W>-
" map = <C-W>+
" 
" map _ <C-W><
" map + <C-W>>

" let g:airline#extensions#tabline#enabled = 1

let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.o$', '\.gcda$', '\.gcno$']

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_global_default.py'
let g:ycm_confirm_extra_conf = 0

" TODO Can run `rustc --print sysroot` to determine
" the first 5 levels of this path, which include all
" system dependent information.
" Needed to run `rustup component add rust-src` to get this
" source code initially. I believe `rustup update` will keep
" it up to date properly.
let g:ycm_rust_src_path = '/home/jason/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:rustfmt_autosave = 1

" Syntastic defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1
      \}

" rustc checker enabled
" Fix for issue with using rustc instead of cargo check:
" https://github.com/rust-lang/rust.vim/issues/130
let g:syntastic_rust_rustc_exe = 'rustup run nightly cargo clippy'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = ''
let g:syntastic_rust_checkers = ['rustc']

" fzf and rg integration
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

autocmd FileType make,go setlocal noexpandtab
  
autocmd BufNewFile,BufRead *.rs set filetype=rust
autocmd BufNewFile,BufRead *.jl set filetype=julia

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
