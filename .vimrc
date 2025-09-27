" Maintainer:
"       Nick Novo
" Contacts: Telegram:
"           t.me/xtose
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'majutsushi/tagbar'
Plug 'jmcantrell/vim-virtualenv'
Plug 'skywind3000/asyncrun.vim'
Plug 'Chiel92/vim-autoformat'

" themes
Plug 'wojciechkepka/vim-github-dark'
Plug 'vim-airline/vim-airline'
Plug 'frazrepo/vim-rainbow'
Plug 'ryanoasis/vim-devicons'

call plug#end()

filetype plugin indent on
syntax on

let python_highlight_all=1

set mouse=a

colorscheme ghdark
let g:gh_color = "soft"
let g:rainbow_active = 1

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#keymap#enabled = 0
let g:airline_section_z = "\ue0a1:%l/%L Col:%c"
let g:Powerline_symbols='unicode'

" cli
set t_Co=256
set termguicolors
set novb
set t_ut=""

" cursor
set ttimeoutlen=5
let &t_SI.="\e[5 q" " insert
let &t_SR.="\e[3 q" " replace
let &t_EI.="\e[1 q" " normal

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" show line numbers
set number

" fold settings
set foldcolumn=3
set foldmethod=indent
set foldlevel=1
nnoremap <space> za

" split
set splitbelow
set splitright

" split navigations
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>


" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp1251,koi8-r,cp866

" Highlight search results
set hlsearch " Show matching brackets

" red line end sting
set textwidth=80
set cc=+1

" autocompletion
set completeopt=menu,menuone,noselect
set complete=.,w,b,u,t,i,d,kspell

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" clipboard 
set clipboard=unnamedplus

set ai "Auto indent
set si "Smart indent

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" autocmd
au BufNewFile,BufRead *.py 
    \ setlocal tabstop=4 
    \ softtabstop=4 
    \ shiftwidth=4 
    \ textwidth=79 
    \ expandtab 
    \ autoindent 
    \ fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :AsyncRun ctags -R<CR>
nmap <F4> :w<CR>:!clear;black %<CR>
nmap <F5> :w<CR>:!clear;isort %<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :Autoformat<CR>
nmap <F10> :w<CR>:!clear; python %<CR>

" managing tabs binding
map <leader>t :tabnew<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>
map <leader>tc :tabclose<CR>
map <leader>tf :tabfirst<CR>
map <leader>tl :tablast<CR>
