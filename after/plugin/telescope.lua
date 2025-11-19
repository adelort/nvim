local builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      ".git/",
      "node_modules/",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

vim.keymap.set("n", "<leader>pa", builtin.find_files, {})
vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
vim.keymap.set("n", "<leader>pr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>pc", builtin.commands, {})
vim.keymap.set("n", "<leader>pj", builtin.jumplist, {})
vim.keymap.set("n", "<leader>pb", function() builtin.buffers({ sort_lastused = true, }) end, {})
vim.keymap.set("n", "<leader>ps", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>pd", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "<leader>pm", builtin.man_pages, {})
vim.keymap.set("n", "<leader>pz", builtin.current_buffer_fuzzy_find, {})

vim.keymap.set("n", "<leader>pg", builtin.git_status, {})
