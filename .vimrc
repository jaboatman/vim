if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

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
Plug 'derekwyatt/vim-scala'

Plug 'SirVer/ultisnips'

Plug 'neomake/neomake' " , { 'commit': '5aeebff' }

" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Or build from source code
" Install yarn from https://yarnpkg.com
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

call plug#end()

" set t_Co=256
let g:gruvbox_italic=1
set termguicolors
set background=dark
" let g:gruvbox_contrast_dark='soft'
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

" coc.vim
let g:coc_node_path = "/home/jason/tools/third-party/node-v10.16.0-linux-x64/bin/node"
set hidden
set nobackup
set nowritebackup

set cmdheight=2

set updatetime=300
set shortmess+=c

set signcolumn=yes

inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" ncm2
" autocmd BufEnter * call ncm2#enable_for_buffer()
" set completeopt=noinsert,menuone,noselect
" set shortmess+=c

" let g:ncm2_pyclang#library_path = '/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'
" TODO Consider
" autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
" let g:ncm2_pyclang#database_path = [
"             \ 'compile_commands.json',
"             \ 'build/compile_commands.json'
"             \ ]
" let g:ncm2#matcher = 'substrfuzzy'
" Snips
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:LanguageClient_hasSnippetSupport = 1

let g:neomake_rust_enabled_makers = ['clippy']
let g:neomake_open_list = 2
call neomake#configure#automake('w')

let g:rustfmt_autosave = 1
let g:rustfmt_command = 'rustup run stable rustfmt'
let g:rustfmt_emit_files = 1

let g:default_julia_version = '1.1.0'

" let g:LanguageClient_serverCommands = {
"         \ 'rust': ['rustup', 'run', 'stable', 'rls'],
"         \ 'cpp': ['~/tools/third-party/ccls/Release/ccls', '--log-file=/tmp/cc.log'],
"         \ 'c': ['~/tools/third-party/ccls/Release/ccls', '--log-file=/tmp/cc.log'],
"         \ 'python': ['pyls'],
"         \ 'go': ['go-langserver']
"         \ }

" let g:LanguageClient_loggingLevel = 'DEBUG'
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition({
"       \ 'gotoCmd': 'tabe',
"       \ })<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" nnoremap <localleader>t :EnType<CR>

" fzf and rg integration
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd FileType make,go setlocal noexpandtab
autocmd BufNewFile,BufReadPost *.jl set filetype=julia

augroup my_neomake_qf
    autocmd!
    autocmd QuitPre * if &filetype !=# 'qf' | lclose | endif
augroup END

" markdown composer
" Don't automatically open the browser window.
let g:markdown_composer_open_browser = 0

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
