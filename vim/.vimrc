" ------------------- COLOR SCHEME -------------------------------------

" DEPRECATED; used this when vim was my main driver on mac
" detects if dark mode enabled and sets colorscheme
"if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
"    set background=dark
"    autocmd vimenter * ++nested colorscheme default
"else
"    colorscheme lunaperche    " light theme (other options: delek, default)
"    set background=light
"endif

set visualbell      " turns on screen flash (no beeping for keyboard errors)
set cursorline      " turns on line/highlight for the line of the cursor
set colorcolumn=81  " turns on highlight for column 81
set laststatus=2    " Always show the status line at the bottom
set scrolloff=12    " keep 12 lines visible from bottom when possible

" ------------------ NUTS & BOLTS ---------------------------------------
syntax enable       " turn on syntax (enable > on)
" set showmatch        highlight matchting [{()}]

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " turns tabs into spaces
set shiftwidth=4    " number of spaces with visiual indent >>
set autoindent      " indent when moving to next line
filetype indent on  " loads filetype-specific indents

" set textwidth=79     limit editor width to 80 characters
set ruler           " shows position of cursor in bottom right
set encoding=utf-8  " set default encoding to utf-8

set number          " adds numbers
set relativenumber  " adds relative numbers above and below cursor line  

set foldmethod=syntax   " allows folding based on code syntax
let g:markdown_folding=1    " enables markdown folding
" set nofoldenable             open all folds when opening a document
set foldlevel=99            " defaults folds open to 99th level

set incsearch       " search as characters are entered
set hlsearch        " highlight matches
set ignorecase      " ignore case in searches, see next
set smartcase       " does not ignore case for capital letters

set backspace=indent,eol,start   " make backspace behave nicer

" ------------------------ SPECIFIC FILETYPE SETTINGS ------------------------ 
autocmd Filetype python setlocal foldmethod=indent

autocmd Filetype markdown setlocal expandtab tabstop=5 shiftwidth=5 softtabstop=5 textwidth=79

autocmd Filetype javascript  setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

autocmd Filetype html  setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

autocmd Filetype css  setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" -------------------- CUSTOM BINDINGS -------------------------------
" leader key is space
let mapleader = " "
" jk is escape
inoremap jk <esc>

nnoremap <leader>w :w<CR>
nnoremap <leader>h :nohl<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>v :Vex<CR>
nnoremap <leader>s :Sex<CR>
nnoremap <leader>= <C-W>=
nnoremap <leader>pp :!python3 %<CR>
nnoremap <leader>jj :!node %<CR>

" move between splits ctrl + j, k, l, hj
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

