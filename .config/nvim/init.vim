set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set nu
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set colorcolumn=100
set signcolumn=yes

call plug#begin('~/.vim/plugged')

Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-eslint', 'coc-tsserver', 'coc-clangd', 'coc-phpls', 'coc-jedi' ]
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" C++
Plug 'dense-analysis/ale'
Plug 'rhysd/vim-clang-format', {'for' : ['c', 'cpp']}
Plug 'puremourning/vimspector', {
  \ 'do': 'python3 install_gadget.py --enable-vscode-cpptools'
  \ }


call plug#end()

syntax enable
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
set background=dark
set termguicolors

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" C++
let g:clang_format#auto_format=1
let g:clang_format#code_style = 'google'

let g:ale_disable_lsp = 1
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'php': ['phpcbf', 'php_cs_fixer'],
    \ 'vim': ['vint'],
    \ 'cpp': [ 'cpplint', 'cppcheck', 'clangtidy', 'clazy'],
\}

let g:ale_fix_on_save = 1
let b:ale_fixers = {
            \'*': ['remove_trailing_lines', 'trim_whitespace'],
            \'javascript': ['prettier', 'eslint']
            \}

let g:ale_sign_column_always = 1
let g:ale_echo_cursor = 1
let g:ale_sign_error = 'E>'
let g:ale_sign_warning = 'W-'

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "tsx", "json", "html", "cpp", "typescript", "css", "scss", "php"
      }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Mappings
let mapleader = " "

" Easy yanking to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

" Easy deletion without saving to register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" open new split panes to right and below
set splitright
set splitbelow

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <C-p> :Files<CR>
nnoremap <C-[> :Ag<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>+  :vertical resize +5<CR>
nmap <leader>-  :vertical resize -5<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <c-h> :CocCommand clangd.switchSourceHeader<CR>

nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>f  <Plug>(coc-codeaction-selected)
nmap <leader>f  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>ff  <Plug>(coc-fix-current)

highlight CocWarningHighlight gui=undercurl guisp=#FFFF00
highlight CocErrorHighlight   gui=undercurl guisp=#FF0000
highlight CocHighlightText    guibg=#005599
highlight Error               gui=undercurl guisp=#FF0000

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


augroup Raphael
    autocmd!

    " start terminal in insert mode
    au BufEnter * if &buftype == 'terminal' | :startinsert | endif

    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

set secure
