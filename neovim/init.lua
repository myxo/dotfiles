vim.g.mapleader = " "

vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'unblevable/quick-scope'
Plug 'rhysd/vim-clang-format'
Plug 'vim-airline/vim-airline'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'airblade/vim-rooter'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'

call plug#end()
]]

-- Common
    vim.opt.encoding = "utf-8"
    vim.opt.fileencoding = "utf-8"
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.autoindent = true
    vim.opt.tabstop = 8
    vim.opt.softtabstop = 0
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 4
    vim.opt.ruler = true
    vim.opt.wrap = true
    vim.opt.cursorline = true           -- Highlight current cursor line
    vim.opt.scrolloff = 6
    vim.opt.colorcolumn = "120"
    vim.opt.backup = false
    vim.opt.writebackup = false
    vim.opt.hidden = true               -- To keep multiple buffers open
    vim.opt.cmdheight = 2               -- Give more space for displaying messages.
    vim.opt.splitbelow = true           -- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
    vim.opt.splitright = true
    -- vim.opt.wildmode=longest,list,full  -- Enable autocompletion in command:
    vim.opt.statusline = "%F"
    vim.opt.list = true
    vim.cmd [[set listchars=tab:▸\ ,trail:·]]
    vim.opt.title = true
    vim.opt.signcolumn = "yes"          -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear
    vim.opt.autoread = true

-- Search
    vim.opt.showmatch = true
    vim.opt.hlsearch = true
    vim.opt.incsearch = true
    vim.opt.ignorecase = true

-- Permament undo
    vim.opt.undodir = os.getenv("HOME") .. "/.vimdid"
    vim.opt.undofile = true


-- Esc is just too far
vim.api.nvim_set_keymap("i", "jj", "<Esc>",  { noremap = true })

-- Turn off hlsearch
vim.api.nvim_set_keymap("n", "<esc><esc>", ":silent! nohls<cr>",  { noremap = true })


-- Goyo plugin makes text more readable when writing prose:
vim.api.nvim_set_keymap("", "<leader>g", ":Goyo \\| set linebreak<CR>",  { noremap = true })

-- Shortcutting split navigation, saving a keypress:
vim.api.nvim_set_keymap("", "<C-h>", "<C-w>h",  { noremap = true })
vim.api.nvim_set_keymap("", "<C-j>", "<C-w>j",  { noremap = true })
vim.api.nvim_set_keymap("", "<C-k>", "<C-w>k",  { noremap = true })
vim.api.nvim_set_keymap("", "<C-l>", "<C-w>l",  { noremap = true })

-- Do not loose selection after tabbing
vim.api.nvim_set_keymap("v", "<", "<gv",  { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv",  { noremap = true })

-- Telescope
vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>Telescope find_files<cr>",  { noremap = true })
vim.api.nvim_set_keymap("n", "<F4>", "<cmd>Telescope live_grep<cr>",  { noremap = true })

-- Reload vimrc
--    nnoremap <leader>rv :source<Space>$MYVIMRC<cr>

-- Edit vimrc
--    nnoremap <leader>ev :vs $MYVIMRC<cr>

-- Toggles between last buffers
vim.api.nvim_set_keymap("n", "<leader><leader>", "<c-^>",  { noremap = true })

-- Really prefer to type :help
vim.api.nvim_set_keymap("", "<F1>", "<Esc>",  { noremap = true })
vim.api.nvim_set_keymap("i", "<F1>", "<Esc>",  { noremap = true })

-- Write readonly files
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee %",  { noremap = true })

-- quick-scope: trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- clang-format
vim.api.nvim_set_keymap("n", "<leader>q", ":ClangFormat<cr>",  { noremap = true })

-- Disables automatic commenting on newline:
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]

-- Gruvbox
vim.cmd [[
    if (has("termguicolors"))
        set termguicolors
        set background=dark 
        let g:gruvbox_contrast_dark='hard'
        colorscheme gruvbox 
    endif
    ]]

-- Floaterm
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_autoclose = 1 -- Close window if the job exits normally
vim.api.nvim_set_keymap("n", "<F12>", ":FloatermToggle<CR>",  { noremap = true })
vim.cmd [[tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>]]

-- LSP stuff

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
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    }),
  })
