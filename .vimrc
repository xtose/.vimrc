" Maintainer:
"       Nick Novo
" Contacts: Telegram:
"           t.me/xtose
"
" -------------------------------------------------------------

set nocompatible
filetype off

" vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'

" theme
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" python
Plug 'klen/python-mode'
Plug 'jmcantrell/vim-virtualenv'
Plug 'jupyter-vim/jupyter-vim'

" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" syntax
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'

call plug#end()

filetype on
filetype plugin on
filetype plugin indent on

" general ------
language messages en_US.UTF-8   " set vim en
set langmenu=en_US.UTF-8        " set langmenu en

set encoding=utf-8

" enable filetype plugins
filetype plugin on
filetype indent on

set hidden

" set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime
 
let python_highlight_all=1
syntax on               " highlight syntax

set ai                  " auto indent
set si                  " smart indent
set wrap                " wrap lines

set foldmethod=indent   " enable folding
set foldlevel=99

set hlsearch            " highlight search
set ignorecase          " do case insensitive search
set incsearch           " show incremental search results as you type
set smartcase           " when searching try to be smart about cases

set nu                  " display line number

set termguicolors

set t_Co=256

colorscheme onehalfdark
set background=dark

" turn backup off
set nobackup
set nowb
set noswapfile

set showmatch           " show the matching part of the pair for [] {} and ()
set ruler               " text after a double-quote is a comment
set cursorline          " show a visual line under cursors current line
set wildmenu            " turn on the Wild menu

" ignore compiled files
set wildignore=*.o,*~,*.pyc,*/,git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set tabstop=4           " set tabs to have 4 spaces
set softtabstop=4
set shiftwidth=4        " when using the >> or <<, shift lines by 4 spaces
set expandtab           " expand tabs into spaces
set smarttab            " be smart when using tabs

" turn off sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=R
set guioptions-=L


" plugin settings ------
" NERDTree
autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']

" Python-mode 
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

let g:pymode_doc = 0
" let g:pymode_doc_key = 'K'

let g:pymode_lint = 1
let g:pymode_lint_checker = 'pyflakes,pep8'
let g:pymode_lint_ignore="E501,W601,C0110"
let g:pymode_lint_write = 1

let g:pymode_virtualenv = 1

let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

let g:pymode_folding = 0

let g:pymode_run = 0

" virtualenv
let g:virtualenv_directory='.'


" hotkeys ------
inoremap jj <ESC>

map <silent> <leader><leader> :noh<CR>

" disabling arrows navigations
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

nnoremap <F2> :NERDTreeRefreshRoot<CR>
nnoremap <F9> :w<CR>:!clear;black %<CR>
nnoremap <F10> ::w!<CR>:!clear;python %<CR>
nnoremap <leader>jc :call jupyter#Connect()<CR>
map <C-w><C-w> :wincmd w<CR>:NERDTreeRefreshRoot<CR>

" managing tabs
map <leader>t :tabnew<CR>:NERDTree<CR>:wincmd w<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>
map <leader>tc :tabclose<CR>
map <leader>tf :tabfirst<CR>
map <leader>tl :tablast<CR>

nmap <silent> gd <Plug>(coc-definition)


" functions ------
" show docs
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  #execfile(activate_this, dict(__file__=activate_this)) # устарел execfile
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF


" highlight settings
hi BadWhitespace ctermbg=red guibg=red
" comments
hi pythonComment cterm=italic ctermfg=grey
hi pythonDocstring cterm=italic ctermfg=grey
hi Comment cterm=italic ctermfg=grey
hi CommentURL cterm=italic ctermfg=grey


" indentation ------
" python
au BufRead,BufNewFile *.py,*pyw set tabstop=4
au BufRead,BufNewFile *.py,*pyw set softtabstop=4
au BufRead,BufNewFile *.py,*pyw set autoindent
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


" for full stack development
au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2
au BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2
