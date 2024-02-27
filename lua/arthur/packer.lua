vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("mbbill/undotree")

	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	use("tpope/vim-surround")

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use("creativenull/efmls-configs-nvim")

	use("numToStr/Comment.nvim")

	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")

	use("nvim-lualine/lualine.nvim")

	use("folke/which-key.nvim")

	use("RRethy/vim-illuminate")

	use("airblade/vim-gitgutter")

	use("nvim-treesitter/nvim-treesitter-context")

	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use({
		"hrsh7th/nvim-cmp",
		after = "nvim-lspconfig",
	})
	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-cmp",
		config = function()
			require("cmp_nvim_lsp").setup({})
		end,
	})
	use({
		"hrsh7th/vim-vsnip",
		after = "nvim-cmp",
	})
	use({
		"hrsh7th/vim-vsnip-integ",
		after = "vim-vsnip",
	})
	use("hrsh7th/cmp-vsnip")

	use("lukas-reineke/indent-blankline.nvim")

	use("machakann/vim-highlightedyank")

	use("windwp/nvim-autopairs")

	use("dyng/ctrlsf.vim")

	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
	})

	use("onsails/lspkind.nvim")

	use("PatschD/zippy.nvim")

	use("zivyangll/git-blame.vim")
end)
