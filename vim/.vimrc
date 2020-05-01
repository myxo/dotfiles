let mapleader =" "

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'unblevable/quick-scope'

Plug 'wikitopian/hardmode'

call plug#end()

" Turn on hard mode by default
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" Basics
        set nocompatible
        filetype plugin on
        syntax on
        set encoding=utf-8
        set number
        set relativenumber
        set autoindent
        set tabstop=8 softtabstop=0 expandtab shiftwidth=4
        set ruler
        set wrap
        set cursorline
        set scrolloff=20
"        set inccommand=nosplit  " interactive replace preview
        set colorcolumn=120

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

" Show TAGS when collecting tags
"        set statusline+=%{gutentags#statusline()}

" Escape terminal
        tnoremap <leader><esc> <C-\><C-n><esc><cr>

" Switch to .c .cpp .h files
        nnoremap <Leader>oc :e %<.c<CR>
        nnoremap <Leader>oC :e %<.cpp<CR>
        nnoremap <Leader>oh :e %<.h<CR>

" Find word under cursor in current and subdirectories
" map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>

" quick-scope: trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

set autoread

if (has("termguicolors"))
    set termguicolors
    set background=dark 
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox 
endif

