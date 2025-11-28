-- Leader key
vim.g.mapleader = " "

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  command = "set formatoptions-=o",
})

-- Prevents a warning in :checkhealth
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.env.LANG = 'en_US.UTF-8'
vim.env.LC_ALL = 'en_US.UTF-8'
vim.env.LC_CTYPE = 'en_US.UTF-8'

-- General settings
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- General keymaps
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>c", vim.cmd.q)
vim.keymap.set("n", "<leader>C", vim.cmd.qa)
vim.keymap.set("n", "<leader>k", vim.cmd.bnext)
vim.keymap.set("n", "<leader>j", vim.cmd.bprevious)
vim.keymap.set("n", "<leader>h", vim.cmd.noh)
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

-- Bootstrap lazy.nvim
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
    config = function()
      require("tokyonight").setup({})
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    cmd = "Telescope",
    keys = {
      { "<leader>pa", function() require("telescope.builtin").find_files() end,                      desc = "Find files" },
      { "<leader>pf", function() require("telescope.builtin").git_files() end,                       desc = "Git files" },
      { "<leader>pr", function() require("telescope.builtin").lsp_references() end,                  desc = "LSP references" },
      { "<leader>pc", function() require("telescope.builtin").commands() end,                        desc = "Commands" },
      { "<leader>pj", function() require("telescope.builtin").jumplist() end,                        desc = "Jumplist" },
      { "<leader>pb", function() require("telescope.builtin").buffers({ sort_lastused = true }) end, desc = "Buffers" },
      { "<leader>ps", function() require("telescope.builtin").lsp_document_symbols() end,            desc = "Document symbols" },
      { "<leader>pd", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,   desc = "Workspace symbols" },
      { "<leader>pm", function() require("telescope.builtin").man_pages() end,                       desc = "Man pages" },
      { "<leader>pz", function() require("telescope.builtin").current_buffer_fuzzy_find() end,       desc = "Fuzzy find in buffer" },
      { "<leader>pg", function() require("telescope.builtin").git_status() end,                      desc = "Git status" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
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
    end,
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
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript", "typescript", "tsx", "c", "lua",
          "vim", "vimdoc", "query", "graphql", "yaml"
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        autotag = {
          enable = true,
          enable_rename = true,
          enable_close = true,
          enable_close_on_slash = true,
          filetypes = { "html", "xml", "javascriptreact", "typescriptreact" },
        },
      })
    end,
  },

  -- LSP Configuration
  {
    "mason-org/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "mason-tool-installer.nvim",
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

      -- LSP Configuration
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set("n", "gp", ":Lspsaga peek_definition<CR>", opts)
        vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)
        vim.keymap.set("n", "<leader>la", ":Lspsaga code_action<CR>", opts)
        vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>", opts)
        vim.keymap.set("n", "<leader>D", ":Lspsaga show_line_diagnostics<CR>", opts)
        vim.keymap.set("n", "<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", opts)
        vim.keymap.set("n", "<leader>lk", ":Lspsaga diagnostic_jump_prev<CR>", opts)
        vim.keymap.set("n", "<leader>lj", ":Lspsaga diagnostic_jump_next<CR>", opts)
        vim.keymap.set("n", "go", ":Lspsaga outline<CR>", opts)
        vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
      end

      -- Lua
      vim.lsp.enable('lua_ls')
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            telemetry = {
              enable = false,
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library"
              },
            },
          },
        },
      })

      -- JSON
      vim.lsp.enable('jsonls')
      vim.lsp.config('jsonls', {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "json", "jsonc" },
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- TypeScript
      vim.lsp.enable('ts_ls')
      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = {
          "typescript",
          "typescriptreact",
          "javascriptreact",
          "javascript",
        },
      })

      -- ESLint
      vim.lsp.enable('eslint')
      vim.lsp.config('eslint', {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Bash
      vim.lsp.enable('bashls')
      vim.lsp.config('bashls', {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "sh", "aliasrc" },
      })

      -- Docker
      vim.lsp.enable('dockerls')
      vim.lsp.config('dockerls', {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- YAML
      vim.lsp.enable('yamlls')
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "yaml", "yml" },
      })

      -- SQL
      vim.lsp.enable('sqlls')
      vim.lsp.config('sqlls', {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "sql" },
      })

      -- Prisma
      vim.lsp.enable('prismals')
      vim.lsp.config('prismals', {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "prisma" },
      })

      -- Rust
      vim.lsp.enable('rust_analyzer')
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {},
        },
      })

      -- GraphQL
      vim.lsp.enable('graphql')
      vim.lsp.config('graphql', {
        root_markers = { '.graphqlrc.yml' },
        filetypes = {
          'graphql',
          'typescript',
          'typescriptreact',
          'javascript',
          'javascriptreact',
        },
        on_attach = on_attach
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
    config = function()
      require("lspsaga").setup({
        move_in_saga = { prev = "<C-k>", next = "<C-j>" },
        finder_action_keys = { open = "<CR>", },
        definition_action_keys = { edit = "<CR>", },
        lightbulb = { enable = false, },
        symbol_in_winbar = { enable = false }
      })
    end,
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
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      -- Command line completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 500
          })
        end,
        desc = "Format file"
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        rust = { "rustfmt" },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        sql = { "pg_format" },
      },
    },
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file explorer" },
      { "<leader>n", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in tree" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 45,
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
    end,
  },

  -- Git Integration
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', '<leader>gj', function()
            if vim.wo.diff then return '<leader>gj' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = 'Next hunk' })

          map('n', '<leader>gk', function()
            if vim.wo.diff then return '<leader>gk' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = 'Previous hunk' })

          -- Actions
          map('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
          map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = 'Stage hunk' })
          map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = 'Reset hunk' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = 'Blame line' })
          map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })
          map('n', '<leader>gd', gs.diffthis, { desc = 'Diff this' })
          map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
        end
      },
    },
  },

  -- Editing Enhancements
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc",        mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb",        mode = { "n", "v" }, desc = "Comment toggle blockwise" },
      { "<leader>/", mode = "n",          desc = "Comment toggle" },
    },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        toggler = {
          line = "<leader>/",
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = { "<C-n>", "<C-Down>", "<C-Up>", "<C-j>", "<C-k>" },
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
    init = function()
      vim.g.highlightedyank_highlight_duration = 100
    end,
  },

  -- UI Enhancements
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    priority = 900,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      scope = {
        enabled = false,
      },
      indent = {
        char = "▏",
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          tsx = {
            icon = "",
            color = "#1354bf",
            cterm_color = "26",
            name = "TypescriptReact",
          },
        },
      })
    end,
  },

  -- Utilities
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
    },
  },
  {
    "dyng/ctrlsf.vim",
    cmd = { "CtrlSF", "CtrlSFToggle" },
    keys = {
      { "<leader>S",  "<Plug>CtrlSFPrompt",    desc = "Search with CtrlSF" },
      { "<leader>sw", "<Plug>CtrlSFCwordPath", desc = "Search word under cursor" },
    },
  },
  {
    "PatschD/zippy.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>lg", "<cmd>lua require('zippy').insert_print()<cr>", desc = "Insert print statement" },
    },
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
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
