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
	"creativenull/efmls-configs-nvim",

	"numToStr/Comment.nvim",

	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",

	"nvim-lualine/lualine.nvim",

	"folke/which-key.nvim",

	"RRethy/vim-illuminate",

	"airblade/vim-gitgutter",

	"nvim-treesitter/nvim-treesitter-context",

	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",
	"hrsh7th/cmp-vsnip",

	"lukas-reineke/indent-blankline.nvim",

	"machakann/vim-highlightedyank",

	"windwp/nvim-autopairs",

	"dyng/ctrlsf.vim",

	"nvimdev/lspsaga.nvim",

	"onsails/lspkind.nvim",

	"PatschD/zippy.nvim",

	"zivyangll/git-blame.vim",

	"prisma/vim-prisma",

	"sbdchd/neoformat",
})
