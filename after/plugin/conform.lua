local conform = require("conform")

conform.setup({})

vim.keymap.set("n", "<leader>f", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500
  })
end)
