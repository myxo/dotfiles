local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { -- LSP
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }
  use 'ray-x/lsp_signature.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use 'navarasu/onedark.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'numToStr/Comment.nvim'

  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  use { 'folke/zen-mode.nvim', config = function() require("zen-mode").setup { } end }
  use 'folke/which-key.nvim'
  use 'unblevable/quick-scope'
  use 'wakatime/vim-wakatime'
  use 'airblade/vim-rooter'

  use 'voldikss/vim-floaterm'

  use {
      "lmburns/lf.nvim",
      config = function()
          -- This feature will not work if the plugin is lazy-loaded
          -- vim.g.lf_netrw = 0

          vim.keymap.set("n", "<leader>fm", ":Lf<CR>")
      end,
      requires = {"nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim"}
  }

  use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup { }
      end
  }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

vim.g.mapleader = " "

-- Can't believe I need to do this...
vim.opt.mouse = ""

-- Common
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

vim.opt.ruler = true
vim.opt.wrap = true
vim.opt.cursorline = true           -- Highlight current cursor line
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "120"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.hidden = true               -- To keep multiple buffers open
vim.opt.cmdheight = 1               -- Give more space for displaying messages.
vim.opt.splitbelow = true           -- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
vim.opt.splitright = true
-- vim.opt.wildmode=longest,list,full  -- Enable autocompletion in command:
vim.opt.statusline = "%F"
vim.opt.list = true
-- vim.cmd [[set listchars=tab:▸\ ,trail:·]]
-- vim.opt.listchars:append("tab:▸\ ")
vim.opt.listchars:append("trail:·")
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
vim.keymap.set('i', "jj", "<Esc>",  { noremap = true, desc = 'switch to normal mode' })

-- Turn off hlsearch
vim.keymap.set("n", "<leader>h", ":silent! nohls<cr>",  { noremap = true, desc = 'silent highlight' })


-- Goyo plugin makes text more readable when writing prose:
vim.keymap.set("n", "<leader>g", "<cmd>ZenMode<CR>",  { noremap = true, desc = 'zen mode' })

-- Shortcutting split navigation, saving a keypress:
vim.keymap.set("", "<C-h>", "<C-w>h",  { noremap = true })
vim.keymap.set("", "<C-j>", "<C-w>j",  { noremap = true })
vim.keymap.set("", "<C-k>", "<C-w>k",  { noremap = true })
vim.keymap.set("", "<C-l>", "<C-w>l",  { noremap = true })

-- Do not loose selection after tabbing
vim.keymap.set("v", "<", "<gv",  { noremap = true })
vim.keymap.set("v", ">", ">gv",  { noremap = true })

-- Telescope
local telescope = require('telescope.builtin')
vim.keymap.set("n", "<leader>p", telescope.git_files,  { noremap = true, desc = 'git files' })
vim.keymap.set("n", "<leader>ff", telescope.find_files,  { noremap = true, desc = 'find files' })
vim.keymap.set("n", "<leader>fg", telescope.live_grep,  { noremap = true, desc = 'grep' })

-- Copy to clipboard (not working?)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Reload vimrc
--    nnoremap <leader>rv :source<Space>$MYVIMRC<cr>

-- Edit vimrc
--    nnoremap <leader>ev :vs $MYVIMRC<cr>

-- Toggles between last buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>",  { noremap = true, desc = 'last buffer' })

-- Really prefer to type :help
vim.keymap.set("", "<F1>", "<Esc>",  { noremap = true })
vim.keymap.set("i", "<F1>", "<Esc>",  { noremap = true })

-- Write readonly files
vim.keymap.set("c", "w!!", "w !sudo tee %",  { noremap = true })

-- quick-scope: trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- Disables automatic commenting on newline:
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]

-- Theme
require('onedark').setup {
    style = 'warm'
}
require('onedark').load()

-- Floaterm
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_autoclose = 1 -- Close window if the job exits normally
vim.keymap.set("n", "<F12>", ":FloatermToggle<CR>",  { noremap = true })
vim.cmd [[tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>]]

-- Golang specifics, use tabs instead of spaces
local go_group = vim.api.nvim_create_augroup("go_settings_group", {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function() vim.opt.expandtab = false end,
    group = go_group
})

require("which-key").setup {
}

vim.keymap.set("n", "<leader>fm", ":Lf<CR>", { noremap = true })

require("lf").setup({
    escape_quit = true,
    border = "rounded",
    --highlights = {FloatBorder = {guifg = require("kimbox.palette").colors.magenta}}
})


require('lsp')
require('treesitter')
