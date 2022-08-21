
vim.opt.completeopt = {"menu", "menuone", "noselect"}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = 0})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = 0})
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {buffer = 0})
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer = 0})
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer = 0})
  vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer = 0})
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {buffer = 0})
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting, {buffer = 0})
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {buffer = 0})
  vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, {buffer = 0})

  require "lsp_signature".on_attach(signature_setup, bufnr)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local nvim_lsp = require'lspconfig'

nvim_lsp.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = false
                }
            }
        }
    },
}

nvim_lsp.clangd.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { 'clangd-13' },
}

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
