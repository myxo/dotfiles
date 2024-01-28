
vim.opt.completeopt = {"menu", "menuone", "noselect"}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false -- turn off stupid snippets for all lsp

local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0, desc = 'hover help'})
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = 0, desc = 'declaration'})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0, desc = 'definition'})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0, desc = 'implementation'})
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0, desc = 'type defenition'})
  vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, {desc = 'references'})
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer = 0, desc = 'next problem'})
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer = 0, desc = 'prev problem'})
  vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0, desc = 'list problems'})
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {buffer = 0, desc = 'rename'})
  vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {buffer = 0, desc = 'code action'})
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, {buffer = 0, desc = 'signature'})
  vim.keymap.set("i", "<C-@>", vim.lsp.buf.signature_help, {buffer = 0, desc = 'signature'})

  -- require "lsp_signature".on_attach(signature_setup, bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'gopls', 'clangd', 'rust_analyzer' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local nvim_lsp = require'lspconfig'

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  expand = function(args)
    require('luasnip').lsp_expand(args.body)
  end,
},
window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'luasnip' },
}, {
  { name = 'buffer' },
})
})
