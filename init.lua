require("arthur")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	command = "set formatoptions-=o",
})

-- Prevents a warning in :checkhealth
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
