local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gr", ":Lspsaga finder<CR>", opts)
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

-- rust
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {},
	},
})

local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")
local eslint = require("efmls-configs.linters.eslint")
local prettier = require("efmls-configs.formatters.prettier")
local shfmt = require("efmls-configs.formatters.shfmt")
local hadolint = require("efmls-configs.linters.hadolint")
local sql_formatter = require("efmls-configs.formatters.sql-formatter")
local rustfmt = require("efmls-configs.formatters.rustfmt")

local languages = {
	lua = { luacheck, stylua },
	json = { eslint, prettier },
	sh = { shfmt },
	javascript = { eslint, prettier },
	typescript = { eslint, prettier },
	javascriptreact = { eslint, prettier },
	typescriptreact = { eslint, prettier },
	markdown = { prettier },
	docker = { hadolint, prettier },
	html = { prettier },
	css = { prettier },
	yaml = { prettier },
	sql = { sql_formatter },
	rust = { rustfmt },
}

local efmls_config = {
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		-- completion = true,
	},
}

lspconfig.efm.setup(efmls_config)
