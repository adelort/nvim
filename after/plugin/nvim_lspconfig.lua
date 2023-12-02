-- local diagnostic_signs = { Error = " ", Warn = " ", Hint = "󱧤", Info = "" }

-- local config = function()
-- require("neoconf").setup({})
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

-- for type, icon in pairs(diagnostic_signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- lua
lspconfig.lua_ls.setup({
	-- capabilities = capabilities,
	-- on_attach = on_attach,
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
	filetypes = { "json", "jsonc" },
})

-- typescript
lspconfig.tsserver.setup({
	capabilities = capabilities,
	filetypes = {
		"typescript",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
})

-- bash
lspconfig.bashls.setup({
	capabilities = capabilities,
	filetypes = { "sh", "aliasrc" },
})

-- docker
lspconfig.dockerls.setup({
	capabilities = capabilities,
})

-- yaml
lspconfig.yamlls.setup({
	capabilities = capabilities,
	filetypes = { "yaml", "yml" },
})

-- sql
lspconfig.sqlls.setup({
	capabilities = capabilities,
	filetypes = { "sql" },
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

		vim.lsp.buf.format({ name = "efm" })
	end,
})
