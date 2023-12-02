vim.cmd([[ set updatetime=100 ]])

vim.keymap.set("n", "<leader>gj", ":GitGutterNextHunk<CR>")
vim.keymap.set("n", "<leader>gk", ":GitGutterPrevHunk<CR>")
vim.keymap.set("n", "<leader>gs", ":GitGutterStageHunk<CR>")
vim.keymap.set("n", "<leader>gr", ":GitGutterUndoHunk<CR>")
vim.keymap.set("n", "<leader>gp", ":GitGutterPreviewHunk<CR>")

vim.g.gitgutter_map_keys = 0
