local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	"mbbill/undotree",

	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"tpope/vim-surround",

	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},

	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",

	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",

	"nvim-lualine/lualine.nvim",

	"airblade/vim-gitgutter",

	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",

	"lukas-reineke/indent-blankline.nvim",

	"machakann/vim-highlightedyank",

	"windwp/nvim-autopairs",

	"dyng/ctrlsf.vim",

	"nvimdev/lspsaga.nvim",

	"onsails/lspkind.nvim",

	"PatschD/zippy.nvim",

	"zivyangll/git-blame.vim",

	"prisma/vim-prisma",

  {
    'stevearc/conform.nvim',
    opts = {},
  },

	"windwp/nvim-ts-autotag",

	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_maps = {
				["Add Cursor Down"] = "<C-j>",
				["Add Cursor Up"] = "<C-k>",
			}
		end,
	},
	{
		"vidocqh/data-viewer.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kkharji/sqlite.lua", -- Optional, sqlite support
		},
	},
  "rust-lang/rust.vim",
  {
    "b0o/schemastore.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
})
