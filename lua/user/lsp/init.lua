local mason_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_status_ok then
	return
end

mason_lsp.setup {
	-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
	-- This setting has no relation with the `automatic_installation` setting.
	ensure_installed = { "clangd", "bashls", "neocmake", "lua_ls", "pyright", "rust_analyzer", "zls", "tsserver",
		"jsonls", "ols", "glsl_analyzer" },

	-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Servers are not automatically installed.
	--   - true: All servers set up via lspconfig are automatically installed.
	--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
	automatic_installation = true,
}

local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_status_ok then
	return
end

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}

mason_lsp.setup_handlers {
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup(opts)
	end,
	["pyright"] = function()
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)

		lspconfig["pyright"].setup(opts)
	end,
	["jsonls"] = function()
		local jsonls_opts = require("user.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)

		lspconfig["jsonls"].setup(opts)
	end,
	["lua_ls"] = function()
		local lua_ls_opts = require("user.lsp.settings.lua_ls")
		opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)

		lspconfig["lua_ls"].setup(opts)
	end,
	["ols"] = function()
		local ols_opts = require("user.lsp.settings.ols")
		opts = vim.tbl_deep_extend("force", ols_opts, opts)

		lspconfig.ols.setup(opts)
	end,
	["markdown_oxide"] = function()
		local md_ox_opts = require("user.lsp.settings.markdown-oxide")
		opts = vim.tbl_deep_extend("force", md_ox_opts, opts.capabilities)

		lspconfig.markdown_oxide.setup(opts)
	end
}

require("user.lsp.handlers").setup()
