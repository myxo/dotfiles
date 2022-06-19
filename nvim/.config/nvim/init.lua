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

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()
]]

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
vim.opt.scrolloff = 6
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
vim.api.nvim_set_keymap("i", "jj", "<Esc>",  { noremap = true })

-- Turn off hlsearch
vim.api.nvim_set_keymap("n", "<leader>h", ":silent! nohls<cr>",  { noremap = true })


-- Goyo plugin makes text more readable when writing prose:
vim.api.nvim_set_keymap("", "<leader>g", "<cmd>ZenMode<CR>",  { noremap = true })

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

-- Golang specifics, use tabs instead of spaces
local go_group = vim.api.nvim_create_augroup("go_settings_group", {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function() vim.opt.expandtab = false end,
    group = go_group
})


require('lsp')
