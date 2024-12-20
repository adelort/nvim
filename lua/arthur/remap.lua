vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>c", vim.cmd.q)
vim.keymap.set("n", "<leader>C", vim.cmd.qa)

vim.keymap.set("n", "<leader>k", vim.cmd.bnext)
vim.keymap.set("n", "<leader>j", vim.cmd.bprevious)

vim.keymap.set("n", "<leader>h", vim.cmd.noh)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set({ "n", "v" }, "<leader>y", '"*y')

vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<Esc>b", "<S-Left>")
vim.keymap.set("c", "<Esc>f", "<S-Right>")
