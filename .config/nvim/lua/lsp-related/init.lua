local lspconfig = require("lspconfig")
local configs = require("lspconfig/configs")
local telescope_builtin = require("telescope.builtin")

local autocmds = require("autocmds")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

-- Border for diagnostic windows
vim.diagnostic.config {
    float = { border = "rounded" },
}

-- Rounded borders for the hover floating window
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = 'rounded'
  }
)

-- Border for the lsp info window
-- Need to update the color of the border (it's)
local lsp_wins = require('lspconfig.ui.windows')
lsp_wins.default_options.border = 'rounded'


local on_attach = function(client, bufnr)
	if client.name ~= "efm"
    and client.name ~= "rust_analyzer"
    and client.name ~= "ocamllsp"
    and client.name ~= "ruby_ls"
  then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end

	if client.server_capabilities.documentFormattingProvider then
		autocmds.set_format_on_save()
	end

	if client.server_capabilities.documentHighlightProvider then
		autocmds.set_au_cursor_hold(bufnr)
		autocmds.set_au_cursor_move(bufnr)
	end

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", function()
		telescope_builtin.lsp_references({ show_line = false })
	end, bufopts)
	vim.keymap.set("n", "<space>lf", vim.lsp.buf.formatting, bufopts)
end

-- JS/TS
lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
-- JS/TS end

-- Rust
local rust_opts = {
	tools = { -- rust-tools options
		autoSetHints = true,
		-- This options below is deprecated.
		-- hover_with_actions = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	server = {
		-- on_attach is a callback called when the language server attachs to the buffer
		on_attach = on_attach,
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				-- enable clippy on save
				checkOnSave = {
					allTargets = true,
					enable = true,
					command = "clippy",
				},
				completion = {
					autoimportEnabled = true,
				},
			},
		},
	},
}

require("rust-tools").setup(rust_opts)

-- Rust end

-- Bash
lspconfig.bashls.setup({
	capabilities = capabilities,
})
-- Bash end

-- Dot/graphviz
lspconfig.dotls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
-- Dot/graphviz end

-- Tailwindcss
lspconfig.tailwindcss.setup({
  -- on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir",
		"elixir",
		"ejs",
		"erb",
		"eruby",
		"gohtml",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"rust",
	},
	init_options = {
		userLanguages = {
			rust = "html",
		},
	},
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "classList" },
		},
	},
})
-- Tailwindcss end

-- HTML
lspconfig.html.setup({
	capabilities = capabilities,
})
-- HTML end

-- SQL
lspconfig.sqlls.setup({
	cmd = { "sql-language-server", "up", "--method", "stdio" },
	capabilities = capabilities,
})
-- SQL end

-- CSS
lspconfig.cssls.setup({
	capabilities = capabilities,
})
-- CSS end

-- EFM
local eslint = {
	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	formatStdin = true,
}

local prettier = { formatCommand = "npx prettier --stdin-filepath ${INPUT}", formatStdin = true }

local config = {
	css = { prettier },
	html = { prettier },
	javascript = { prettier, eslint },
	javascriptreact = { prettier, eslint },
	json = { prettier },
	markdown = { prettier },
	scss = { prettier },
	typescript = { prettier, eslint },
	typescriptreact = { prettier, eslint },
}

lspconfig.efm.setup({
	init_options = { documentFormatting = true },
	cmd = { "efm-langserver", "-logfile", "/tmp/efm.log", "-loglevel", "5" },
	filetypes = vim.tbl_keys(config),
	settings = {
		rootMarkers = { ".git/" },
		languages = config,
	},
	on_attach = on_attach,
	capabilities = capabilities,
})
-- EFM end

-- Emmet (TODO: this is not working)
if not lspconfig.emmet_ls then
	configs.emmet_ls = {
		default_config = {
			cmd = { "emmet-ls", "--stdio" },
			filetypes = { "html", "css", "typescriptreact" },
			root_dir = function(fname)
				return vim.loop.cwd()
			end,
			settings = {},
		},
	}
end

lspconfig.emmet_ls.setup({
	capabilities = capabilities,
})
-- Emmet end

-- Copilot

-- enable copilot for gitcommit files
vim.cmd([[
    let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ 'markdown': v:true,
    \ }
]])

-- Copilot end

-- Lua
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "hs" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
  on_attach = on_attach,
  capabilities = capabilities,
})
-- Lua end

-- Marksman
require("lspconfig").marksman.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- Marksman end

-- Solargraph
require("lspconfig").solargraph.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "/Users/placeit/.gem/ruby/2.7.0/bin/solargraph", "stdio" },
})
-- Solargraph end

-- OCaml
require("lspconfig").ocamllsp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}
-- OCaml end

-- Lsp init progress
require'fidget'.setup {}
-- Lsp init progress end
