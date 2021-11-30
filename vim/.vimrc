let mapleader =" "

call plug#begin('~/.local/share/nvim/plugged')

" Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'unblevable/quick-scope'
Plug 'vimwiki/vimwiki'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'

" lol
Plug 'wikitopian/hardmode'

Plug 'liuchengxu/vim-which-key'

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

" Search
    set showmatch 
    set hlsearch
    set incsearch
    set ignorecase

" Permament undo
    set undodir=~/.vimdid
    set undofile


" For copy/paste to another programs:
    vnoremap <C-c> "*Y :let @+=@*<CR>
    map <C-y> "+P

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

" Fzf
    nnoremap <leader>p :GFiles --cached --others --exclude-standard<cr>
    nnoremap <leader>; :Buffers<cr>

    let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8, 'xoffset': 0.5}}


" Escape terminal
    tnoremap <leader><esc> <C-\><C-n><esc><cr>

" Switch to .c .cpp .h files
    nnoremap <Leader>oc :e %<.c<CR>
    nnoremap <Leader>oC :e %<.cpp<CR>
    nnoremap <Leader>oh :e %<.h<CR>

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
    map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>

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

" WhichKey
    nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" >>>>>>>>>>>> Coc settings


" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
"enoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
