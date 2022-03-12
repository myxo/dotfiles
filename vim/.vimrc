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

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'

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


lua <<EOF
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local opts = { noremap=true, silent=true }

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { 'rls' }
    for _, lsp in pairs(servers) do
      require('lspconfig')[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        }
      }
    end

    require('lspconfig')['clangd'].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { 'clangd-13' },
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }),
  })
EOF
