local builtin = require('telescope.builtin')

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "^.git/",
      "^.node_modules/",
    }
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

vim.keymap.set('n', '<leader>pa', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>pr', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pc', builtin.commands, {})
vim.keymap.set('n', '<leader>pj', builtin.jumplist, {})
