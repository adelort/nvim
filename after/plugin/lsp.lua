require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'tsserver',
    },
})

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {})
vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, {})
vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, {})
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})

vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, {})
vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, {})
vim.keymap.set("n", "<leader>lj", function() vim.diagnostic.goto_next() end, {})
vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.goto_prev() end, {})
vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, {})

require("lspconfig").lua_ls.setup {}

require("lspconfig").tsserver.setup {}

