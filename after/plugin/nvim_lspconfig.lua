local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

local capabilities = cmp_nvim_lsp.default_capabilities()

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gr", ":Lspsaga finder<CR>", opts)
	vim.keymap.set("n", "gp", ":Lspsaga peek_definition<CR>", opts)
	vim.keymap.set("n", "gd", ":Lspsaga goto_definition<CR>", opts)
	vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
	vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>", opts)
	vim.keymap.set("n", "<leader>D", ":Lspsaga show_line_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", opts)
	vim.keymap.set("n", "<leader>lk", ":Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.keymap.set("n", "<leader>lj", ":Lspsaga diagnostic_jump_next<CR>", opts)
	vim.keymap.set("n", "go", ":Lspsaga outline<CR>", opts)
	vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
end

-- lua
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			telemetry = {
				enable = false,
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

-- json
lspconfig.jsonls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "json", "jsonc" },
})

-- typescript
lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascriptreact",
		"javascript",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
})

-- bash
lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "sh", "aliasrc" },
})

-- docker
lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- yaml
lspconfig.yamlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "yaml", "yml" },
})

-- sql
lspconfig.sqlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "sql" },
})

-- prisma
lspconfig.prismals.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "prisma" },
})

local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")
local eslint_d = require("efmls-configs.linters.eslint_d")
local prettier_d = require("efmls-configs.formatters.prettier_d")
local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")
local hadolint = require("efmls-configs.linters.hadolint")
local sql_formatter = require("efmls-configs.formatters.sql-formatter")

-- configure efm server
lspconfig.efm.setup({
	filetypes = {
		"lua",
		"json",
		"sh",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"markdown",
		"docker",
		"html",
		"css",
		"yaml",
		"sql",
		"prisma",
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
	},
	settings = {
		languages = {
			lua = { luacheck, stylua },
			typescript = { eslint_d, prettier_d },
			json = { eslint_d, prettier_d },
			sh = { shellcheck, shfmt },
			javascript = { eslint_d, prettier_d },
			javascriptreact = { eslint_d, prettier_d },
			typescriptreact = { eslint_d, prettier_d },
			markdown = { prettier_d },
			docker = { hadolint, prettier_d },
			html = { prettier_d },
			css = { prettier_d },
			yaml = { prettier_d },
			sql = { sql_formatter },
		},
	},
})

-- Format on save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_active_clients({ name = "efm" })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm", async = true })
	end,
})
