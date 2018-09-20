if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'

Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mkitt/tabline.vim'
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'

Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-bufword'

Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-go'

Plug 'neomake/neomake', { 'commit': '5aeebff' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }


Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" set t_Co=256
let g:gruvbox_italic=1
set termguicolors
set background=dark
colorscheme gruvbox
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
autocmd BufReadPost *.rs set filetype=rust
autocmd BufWritePost *.rs Neomake! clippy

let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.o$', '\.gcda$', '\.gcno$']

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c

let g:ncm2_pyclang#library_path = '/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'
" TODO Consider
" autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
let g:ncm2_pyclang#database_path = [
            \ 'compile_commands.json',
            \ 'build/compile_commands.json'
            \ ]
let g:ncm2#matcher = 'substrfuzzy'
" Snips
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

let g:neomake_rust_enabled_makers = ['clippy']
let g:neomake_open_list = 2
call neomake#configure#automake('w')

let g:rustfmt_autosave = 1
" let g:rustfmt_command = 'rustup run nightly rustfmt'
let g:rustfmt_emit_files = 1

let g:LanguageClient_serverCommands = {
        \ 'rust': ['rustup', 'run', 'stable', 'rls'],
        \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition({
      \ 'gotoCmd': 'tabe',
      \ })<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" fzf and rg integration
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd FileType make,go setlocal noexpandtab
autocmd BufNewFile,BufRead *.jl set filetype=julia

augroup my_neomake_qf
    autocmd!
    autocmd QuitPre * if &filetype !=# 'qf' | lclose | endif
augroup END
