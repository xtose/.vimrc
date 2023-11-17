" Maintainer:
"       Nick Novo
" Contacts: Telegram:
"           t.me/xtose

" general
filetype plugin indent on
set nocompatible
set hidden
syntax enable
set backspace=indent,eol,start

" lang
language messages en_US
set langmenu=en_US
" let $LANG="en_US"

" splits
set splitright

" encoding
scriptencoding utf-8
set encoding=utf-8

" indent
set smartindent
set copyindent

" tabs
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" visual
set nu
set wrap linebreak nolist
set showtabline=1
set cursorline
set textwidth=80
set showcmd
set ttyfast
set scrolloff=5

" cursor
set ttimeoutlen=10
let &t_SI.="\e[5 q" " insert
let &t_SR.="\e[3 q" " replace
let &t_EI.="\e[1 q" " normal

" searching
set incsearch
set ignorecase
set hlsearch
set smartcase

" folding
set foldnestmax=10
set foldlevel=2
set nofoldenable
set foldlevelstart=0

" cli
set t_Co=256
set termguicolors
set novb
set t_ut=""

" backup
set nobackup
set nowb
set noswapfile

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'jupyter-vim/jupyter-vim'
Plug 'Valloric/YouCompleteMe'
Plug 'skywind3000/asyncrun.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'klen/python-mode'
Plug 'nvie/vim-flake8'
call plug#end()

" ycm
let g:ycm_show_diagnostics_ui = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline_section_z = "\ue0a1:%l/%L Col:%c"
let g:Powerline_symbols='unicode'

" rainbow
let g:rainbow_active = 1

" python-mode
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
" - docs
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" - lint
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110"
let g:pymode_lint_write = 1
" - virtualvenv
let g:pymode_virtualenv = 1
" - breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
" - syntax
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
" - folding
let g:python_folding = 0
" - run
let g:pymode_run = 0

" theme
colorscheme gruvbox
set background=dark

" set leader
let mapleader = "\\"

" function binding
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :AsyncRun ctags -R<CR>
nnoremap <F5> :Autoformat<CR>
nnoremap <F6> :!source venv/bin/activate<CR>
nnoremap <F8> :w<CR>:!clear;black %<CR>
nnoremap <F9> :w<CR>:!clear;isort %<CR>
nnoremap <F10> :w<CR>:!clear;python %<CR>

" managing tabs binding
map <leader>t :tabnew<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>
map <leader>tc :tabclose<CR>
map <leader>tf :tabfirst<CR>
map <leader>tl :tablast<CR>

" highlight
highlight Comment cterm=italic ctermfg=grey
