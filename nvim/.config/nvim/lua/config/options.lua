vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]

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
vim.opt.cursorline = true -- Highlight current cursor line
vim.opt.scrolloff = 10
vim.opt.colorcolumn = "120"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.hidden = true -- To keep multiple buffers open
vim.opt.cmdheight = 1 -- Give more space for displaying messages.
vim.opt.splitbelow = true -- Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
vim.opt.splitright = true
-- vim.opt.wildmode=longest,list,full  -- Enable autocompletion in command:
-- vim.opt.statusline = "%F"
--
-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.title = true
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear
vim.opt.autoread = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Permament undo
vim.opt.undodir = os.getenv("HOME") .. "/.vimdid"
vim.opt.undofile = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Decrease update time
vim.opt.updatetime = 250

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- quick-scope: trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
