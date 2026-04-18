return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"lua",
			"rust",
			"go",
			"luadoc",
			"markdown",
			"vim",
			"vimdoc",
		},
	},
	config = function(_, opts)
		local treesitter = require("nvim-treesitter")
		treesitter.setup()

		local installed = treesitter.get_installed()
		local missing = vim.tbl_filter(function(lang)
			return not vim.list_contains(installed, lang)
		end, opts.ensure_installed or {})

		if #missing > 0 then
			treesitter.install(missing, { summary = true })
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("nvim-treesitter-start", { clear = true }),
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
