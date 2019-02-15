let mapleader =" "

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()



" Basics
        set nocompatible
        filetype plugin on
        syntax on
        set encoding=utf-8
        set number
        set relativenumber
        set autoindent
        set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
        set ruler
        set wrap
        set cursorline


" For copy/paste to another programs:
        vnoremap <C-c> "*Y :let @+=@*<CR>
        map <C-y> "+P

" Enable autocompletion in command:
        set wildmode=longest,list,full

" Search
        set showmatch 
        set hlsearch
        set incsearch
        set ignorecase

" Turn off hlsearch
        nnoremap <esc><esc> :silent! nohls<cr>

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set linebreak<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

set autoread

if (has("termguicolors"))
    set termguicolors
    set background=dark 
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox 
endif

