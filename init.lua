require("arthur")

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
 command = 'set formatoptions-=o',
})



