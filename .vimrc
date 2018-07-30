if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'

Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mkitt/tabline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

" Plug 'roxma/nvim-completion-manager'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'

Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-bufword'

Plug 'ncm2/ncm2-racer'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-go'

Plug 'neomake/neomake'
" Plug 'Valloric/YouCompleteMe'
" Plug 'vim-syntastic/syntastic'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': './install.sh'
"     \ }
" 

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

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
autocmd BufReadPost *.rs set filetype=rust
autocmd BufWritePost *.rs Neomake! clippy

" Automatically start language servers.
" let g:LanguageClient_autoStart = 1

let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.o$', '\.gcda$', '\.gcno$']

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
set shortmess+=c

" TODO Verify
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'
" TODO Consider
" autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
let g:ncm2_pyclang#database_path = [
            \ 'compile_commands.json',
            \ 'build/compile_commands.json'
            \ ]
" Snips
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

let g:cm_matcher={'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}

let g:neomake_rust_enabled_makers = ['clippy']
let g:neomake_open_list = 2
call neomake#configure#automake('w')

" let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_global_default.py'
" let g:ycm_confirm_extra_conf = 0

" TODO Can run `rustc --print sysroot` to determine
" the first 5 levels of this path, which include all
" system dependent information.
" Needed to run `rustup component add rust-src` to get this
" source code initially. I believe `rustup update` will keep
" it up to date properly.
" let g:ycm_rust_src_path = '/home/jason/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:rustfmt_autosave = 1
let g:rustfmt_command = 'rustup run nightly rustfmt'
let g:rustfmt_emit_files = 1

" let g:ycm_filetype_specific_completion_to_disable = {
"       \ 'gitcommit': 1
"       \}
" let g:LanguageClient_serverCommands = {
"         \ 'rust': ['rustup', 'run', 'stable', 'rls'],
"         \ }
" 
" let g:LanguageClient_loggingLevel = 'DEBUG'
" autocmd FileType rust setlocal omnifunc=LanguageClient#complete
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

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

" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)
