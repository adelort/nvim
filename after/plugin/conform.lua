local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    rust = { "rustfmt" },
  },
})

vim.keymap.set("n", "<leader>f", function()
  conform.format({
    lsp_fallback = false,
    async = false,
    timeout_ms = 500
  })
end)
