local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Treesitter (syntax highlighting & parsing)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },
  },

  -- LSP Configuration
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup({})

      require("mason-lspconfig").setup({
        automatic_installation = true,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Language Servers
          "bash-language-server",
          "dockerfile-language-server",
          "eslint-lsp",
          "graphql-language-service-cli",
          "json-lsp",
          "lua-language-server",
          "prisma-language-server",
          "sqlls",
          "typescript-language-server",
          "yaml-language-server",

          -- Formatters & Linters
          "prettier",
          "sqlfluff",
          "pgformatter",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "b0o/schemastore.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {},
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Git Integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "airblade/vim-gitgutter",
  "zivyangll/git-blame.vim",

  -- Editing Enhancements
  "tpope/vim-surround",
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },
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
  "machakann/vim-highlightedyank",

  -- UI Enhancements
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },

  -- Utilities
  "mbbill/undotree",
  "dyng/ctrlsf.vim",
  "PatschD/zippy.nvim",

  -- Language-Specific
  "prisma/vim-prisma",
  "rust-lang/rust.vim",

  -- Data Viewer
  {
    "vidocqh/data-viewer.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kkharji/sqlite.lua",
    },
  },
})
