vim.g.mapleader = " "

vim.cmd [[
call plug#begin(stdpath('data') . '/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'folke/zen-mode.nvim'
Plug 'morhetz/gruvbox'
Plug 'unblevable/quick-scope'
Plug 'vim-airline/vim-airline'
Plug 'wakatime/vim-wakatime'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'airblade/vim-rooter'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/which-key.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'ray-x/lsp_signature.nvim'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'

call plug#end()
]]


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


require('lsp')
require('treesitter')
