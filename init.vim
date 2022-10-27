" Load external plugins from lua.
lua require('plugins')
" Auto compile plugins when saving the plugins.lua file.
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" Disable mouse completely.
set mouse=

" set pyxversion=python3

set encoding=UTF-8
" this variable must be enabled for colors to be applied properly
set termguicolors 

" Colorscheme
let g:gruvbox_italic=1
set background=dark
" let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox
" let g:everforest_better_performance = 1
" let g:everforest_background='hard'
" " colorscheme everforest
" 
" let g:edge_better_performance = 1
" let g:edge_style='aura'
" 
" " let g:gruvbox_material_background = 'hard'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_foreground = 'original'
" " colorscheme gruvbox-material
" 
" " Example config in VimScript
" " let g:gruvbox_baby_function_style = "NONE"
" let g:gruvbox_baby_keyword_style = "NONE"
" 
" " Enable telescope theme
" let g:gruvbox_baby_telescope_theme = 1
" 
" " Enable transparent mode
" let g:gruvbox_baby_background_color = 'medium'
" let g:gruvbox_baby_transparent_mode = 0
" let g:gruvbox_baby_use_original_palette = 1
" 
" " Load the colorscheme
" colorscheme gruvbox-baby
" colorscheme edge
" colorscheme nightfox 
" colorscheme terafox

" Basic configuration.
set tabstop=2
set shiftwidth=2
set expandtab
set cc=100
set nu

let mapleader = ','

" NvimTree commands.
nnoremap <C-n> :NvimTreeToggle<CR>

set hidden
set nobackup
set nowritebackup

set cmdheight=2

" COC
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Spell checking.
set spelllang=en
augroup spellCheck
  autocmd!
  autocmd BufReadPost,BufNewFile *.txt,*.md setlocal spell
augroup END

" Various COC related configurations.
inoremap <silent><expr> <c-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>ac <Plug>(coc-codeaction)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (expand('%:t') == 'Cargo.toml')
    lua require('crates').show_popup()
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>


" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Snippets configuration
" c-j c-k for moving in snippet
" let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:LanguageClient_hasSnippetSupport = 1

" rustlang
" Set rust filetype automatically.
autocmd BufReadPost *.rs set filetype=rust
let g:rustfmt_autosave = 1
let g:rustfmt_command = 'rustup run stable rustfmt'
let g:rustfmt_emit_files = 1

" julialang
let g:default_julia_version = '1.4.1'
autocmd BufNewFile,BufReadPost *.jl set filetype=julia

" FZF file opening.
nnoremap <silent><nowait> <space>o :FzfLua files<cr>
nnoremap <silent><nowait> <space>b :FzfLua buffers<cr>
nnoremap <silent><nowait> <space>/ :FzfLua blines<cr>
nnoremap <nowait> <space>s :FzfLua grep<cr>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Misc
autocmd FileType make,go setlocal noexpandtab
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
