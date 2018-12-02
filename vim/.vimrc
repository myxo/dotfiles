set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number
set relativenumber

" for copy/paste to another programs:
	vnoremap <C-c> "*Y :let @+=@*<CR>
	map <C-p> "+P


set showmatch 
set hlsearch
set incsearch
set ignorecase

" Turn off hlsearch
	nnoremap <esc><esc> :silent! nohls<cr>

set autoread
set ignorecase
syntax enable 

set autoindent
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set ruler
set showmatch

set wrap
colorscheme zellner
