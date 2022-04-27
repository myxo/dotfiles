let mapleader =" "

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'unblevable/quick-scope'
Plug 'vimwiki/vimwiki'
Plug 'rhysd/vim-clang-format'
Plug 'vim-airline/vim-airline'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'airblade/vim-rooter'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'lukas-reineke/indent-blankline.nvim'

" lol
Plug 'wikitopian/hardmode'

call plug#end()

" Turn on hard mode by default
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" Common
    set nocompatible
    filetype plugin on
    syntax on
    set encoding=utf-8
    set fileencoding=utf-8
    set number
    set relativenumber
    set autoindent
    set tabstop=8 softtabstop=0 expandtab shiftwidth=4
    set ruler
    set wrap
    set cursorline          " Highlight current cursor line
    set scrolloff=6
"        set inccommand=nosplit  " interactive replace preview
    set colorcolumn=120
    set nobackup
    set nowritebackup
    set hidden              " To keep multiple buffers open
    set cmdheight=2         " Give more space for displaying messages.
    set splitbelow splitright " Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
    set wildmode=longest,list,full " Enable autocompletion in command:
    set statusline=%F
    set list
    set listchars=tab:▸\ ,trail:·
    set title
    set signcolumn=yes      " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear

" Search
    set showmatch 
    set hlsearch
    set incsearch
    set ignorecase

" Permament undo
    set undodir=~/.vimdid
    set undofile


" For copy/paste to another programs:
    " vnoremap <C-c> "*Y :let @+=@*<CR>
    " map <C-y> "+P

" Esc is just too far
    inoremap jj <Esc>

" Turn off hlsearch
    nnoremap <esc><esc> :silent! nohls<cr>

" Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
    map <leader>g :Goyo \| set linebreak<CR>

" Shortcutting split navigation, saving a keypress:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" Do not loose selection after tabbing
    vnoremap < <gv
    vnoremap > >gv

" Telescope
    nnoremap <leader>p <cmd>Telescope find_files<cr>
    nnoremap <F4> <cmd>Telescope live_grep<cr>

" Escape terminal
    tnoremap <leader><esc> <C-\><C-n><esc><cr>

" Reload vimrc
    nnoremap <leader>rv :source<Space>$MYVIMRC<cr>

" Edit vimrc
    nnoremap <leader>ev :vs $MYVIMRC<cr>

" Toggles between last buffers
    nnoremap <leader><leader> <c-^>

" Really prefer to type :help
    map <F1> <Esc>
    imap <F1> <Esc>

" Build and run (TODO: make actual build script for common cases)
    nnoremap <leader>rr :!gcc % -o %:r && ./%:r<cr>

" Write readonly files
    cmap w!! w !sudo tee %

" Find word under cursor in current and subdirectories
    " map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
    " map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>

" quick-scope: trigger a highlight in the appropriate direction when pressing these keys:
    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Vimwiki
    let g:vimwiki_list = [{ 'path' : '~/vimwiki/', 'syntax' : 'markdown', 'ext' : 'md' }]

set autoread

" Gruvbox
    if (has("termguicolors"))
        set termguicolors
        set background=dark 
        let g:gruvbox_contrast_dark='hard'
        colorscheme gruvbox 
    endif

" Floaterm
    let g:floaterm_width = 0.8
    let g:floaterm_height = 0.8
    let g:floaterm_autoclose = 1 " Close window if the job exits normally
    " let g:floaterm_keymap_new = '<Leader>t'
    nnoremap   <silent>   <F12>   :FloatermToggle<CR>
    tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

" clang-format
    nnoremap <leader>q :ClangFormat<cr>

