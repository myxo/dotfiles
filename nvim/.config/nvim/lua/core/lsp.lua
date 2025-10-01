-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = {},
	virtual_text = {
		source = 'if_many',
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
}
-- TODO: for this work I should pass it to lsp.config, leave it here for now, and try
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('blink.cmp').get_lsp_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = false -- turn off stupid snippets for all lsp

vim.lsp.enable({
	"clangd",
	"gopls",
	"rust_analyzer",
	"lua_ls",
	"zls",
})
vim.lsp.config('rust_analyzer', {
	settings = {
		['rust_analyzer'] = {
			completion = {
				autoimport = {
					enable = false,
				}
			}
		}
	}
})
