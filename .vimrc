" -------------------------------------------------------------
" Maintainer:
"       Nick Novozhenin
"
" Contacts:
"       Telegram:
"           t.me/tose_x
"
" -------------------------------------------------------------

" -> VIM-PLUG
call plug#begin('~/.vim/plugged')

Plug 'plasticboy/vim-markdown'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'jmcantrell/vim-virtualenv'
Plug 'bronson/vim-trailing-whitespace'      " :FixWhitespace
Plug 'junegunn/vim-easy-align'              " :EasyAlign
Plug 'Valloric/YouCompleteMe'

call plug#end()


" -> General
" -------------------------------------------------------------
language messages en_US.UTF-8   " Set vim en
set langmenu=en_US.UTF-8        " Set langmenu en

set encoding=utf-8

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

syntax enable           " Highlight syntax
set ai                  " Auto indent
set si                  " Smart indent
set wrap                " Wrap lines

set foldmethod=indent   " Enable folding
set foldlevel=99

set hlsearch            " Highlight search
set ignorecase          " Do case insensitive search
set incsearch           " Show incremental search results as you type
set smartcase           " When searching try to be smart about cases

set nu                  " Display line number

" Turn backup off
set nobackup
set nowb
set noswapfile

set showmatch           " Show the matching part of the pair for [] {} and ()
set ruler               " Text after a double-quote is a comment
" set cursorline          " Show a visual line under cursors current line
set wildmenu            " Turn on the Wild menu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/,git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set tabstop=4           " Set tabs to have 4 spaces
set shiftwidth=4        " When using the >> or <<, shift lines by 4 spaces
set expandtab           " Expand tabs into spaces
set smarttab            " Be smart when using tabs

" Turn off sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

set t_Co=256            " Enable 256 colors
set background=light    " background light

set laststatus=2        " Always show the status line
set foldcolumn=1        " Add a bit extra margin to the left

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}


" -> Mapping
" -------------------------------------------------------------
inoremap jj <ESC>       " Remap escape to `jj`

" Disable Highlight
map <silent> <leader><leader> :noh<CR>

map <leader>K :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Disabling arrows navigations
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>


" Managing tabs
map <leader>t :tabnew<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>
map <leader>tc :tabclose<CR>
map <leader>tf :tabfirst<CR>
map <leader>tl :tablast<CR>

map <F2> :tabnew<CR>:Explore .<CR>

nmap <F8> :ALEFix<CR>

map <F10> :call CompileRun()<CR>
imap <F10> :call CompileRun()<CR>
vmap <F10> :call CompileRun()<CR>

vnoremap <silent> <Enter> :EasyAlign<CR>


" -> Abr
" -------------------------------------------------------------
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<CR>
iab xtell <C-r>='+7 (987) 654-32-10'<CR>
iab xmail <C-r>='example@example.com'<CR>


" -> Functions
" -------------------------------------------------------------
" Compilers for different systems may differ
func! CompileRun()
exec "w"
if &filetype == 'python'
    !time;python3 %
endif
endfunc

func! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keeepend extend

    func! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunc
    setl foldtext=FoldText()
endfunc

func! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total + l:all_errors

    return l:counts.total == 0 ? '@ all good @' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunc



" -> YouCompleteMe
" -------------------------------------------------------------
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path = './venv/bin/python3'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"


" -> VirtualEnv
" -------------------------------------------------------------
let g:virtualenv_directory='.'


" -> Python-mode
" -------------------------------------------------------------
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_ignore="E501,W601,C0110,E211,E303,E251"

" -> Ale
" -------------------------------------------------------------
let g:ale_fix_on_save = 1

let g:ale_linters = {
    \   'python': ['flake8', 'pylint'],
    \   'ruby': ['standardrb', 'ruboco'],
    \   'javascript': ['eslint'],
    \}

let g:ale_fixers = {
    \   'python': ['yapf'],
    \}



" -y Languages supports
" -------------------------------------------------------------
" * Python section
let python_highlight_all = 1    " Enable all Python syntax highlighting features
au FileType python syn keyword pythonDecorator True None False self
au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.py set textwidth=80
au BufNewFile *.py 0r ~/.vim/skeleton.py

py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate')
    exec(open(activate_this).read(), dict(__file__=activate_this))
EOF



" * JavaScript section
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindnt

au FileType javascript,typescript imap <C-t> console.log();<ESC>hi
au FileType javascript,typescript imap <C-a> alert();<ESC>hi

au FileType javascript,typescript inoremap <buffer> $r return
au FileType javascript,typescript inoremap <buffer> $f // --- PH<Esc>FP2xi

au BufNewFile,BufRead *.js, *.html, *.css
            \ set tabstop=2
            \ set softtabstop=2
            \ set shiftwidth=2


" * CSS section
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" * Shell section
set term=screen-256color

" * Twig section
autocmd BufRead *.twig set syntax=html filetype=html

" * Markdown section
let vim_markdown_folding_disabled = 1
au! BufRead,BufNewFile *.markdown set filetype=mkd
au! BufRead,BufNewFile *.md set filetype=mkd
