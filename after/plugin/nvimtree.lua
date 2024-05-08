require("nvim-web-devicons").setup({
	override = {
		tsx = {
			icon = "",
			color = "#1354bf",
			cterm_color = "26",
			name = "TypescriptReact",
		},
	},
})

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
	},
	filesystem_watchers = {
		ignore_dirs = {
			"node_modules",
			".next",
		},
	},
})

vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
