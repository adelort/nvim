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
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Treesitter (syntax highlighting & parsing)
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },
  },

  -- LSP Configuration
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "b0o/schemastore.nvim",
    lazy = true,
    dependencies = { "neovim/nvim-lspconfig" },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
    event = { "BufReadPre", "BufNewFile" },
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
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "zivyangll/git-blame.vim",
    event = "VeryLazy",
  },

  -- Editing Enhancements
  {
    "tpope/vim-surround",
    event = { "BufReadPost", "BufNewFile" },
  },
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
  {
    "machakann/vim-highlightedyank",
    event = "TextYankPost",
  },

  -- UI Enhancements
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    priority = 900,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
  },

  -- Utilities
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  {
    "dyng/ctrlsf.vim",
    cmd = { "CtrlSF", "CtrlSFToggle" },
  },
  {
    "PatschD/zippy.nvim",
    event = "VeryLazy",
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },

  -- Language-Specific
  {
    "prisma/vim-prisma",
    ft = "prisma",
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
  },

  -- Data Viewer
  {
    "vidocqh/data-viewer.nvim",
    cmd = "DataViewer",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kkharji/sqlite.lua",
    },
  },
})
