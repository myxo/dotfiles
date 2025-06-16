return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		icons = {
			mappings = false,
		},
	},
	-- config = function()
	-- 	require("which-key").setup()

	-- Document existing key chains
	-- require("which-key").register({
	-- 	{ "<leader>c", group = "[C]ode" },
	-- 	{ "<leader>d", group = "[D]ocument" },
	-- 	{ "<leader>h", group = "Git [H]unk" },
	-- 	{ "<leader>r", group = "[R]ename" },
	-- 	{ "<leader>s", group = "[S]earch" },
	-- 	{ "<leader>t", group = "[T]oggle" },
	-- 	{ "<leader>w", group = "[W]orkspace" },
	-- })
	-- visual mode
	-- require("which-key").register({
	-- 	["<leader>h"] = { "Git [H]unk" },
	-- }, { mode = "v" })
	-- end,
}
