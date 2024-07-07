return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local mason_lsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local handlers = require("plugins.lsp.handlers")

			local opts = {
				on_attach = handlers.on_attach,
				capabilities = handlers.capabilities,
			}

			mason_lsp.setup_handlers {
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup(opts)
				end,
				["pyright"] = function()
					local pyright_opts = require("plugins.lsp.settings.pyright")
					opts = vim.tbl_deep_extend("force", pyright_opts, opts)

					lspconfig["pyright"].setup(opts)
				end,
				["jsonls"] = function()
					local jsonls_opts = require("plugins.lsp.settings.jsonls")
					opts = vim.tbl_deep_extend("force", jsonls_opts, opts)

					lspconfig["jsonls"].setup(opts)
				end,
				["lua_ls"] = function()
					local lua_ls_opts = require("plugins.lsp.settings.lua_ls")
					opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)

					lspconfig["lua_ls"].setup(opts)
				end,
				["ols"] = function()
					local ols_opts = require("plugins.lsp.settings.ols")
					opts = vim.tbl_deep_extend("force", ols_opts, opts)

					lspconfig.ols.setup(opts)
				end,
				["markdown_oxide"] = function()
					local md_ox_opts = require("plugins.lsp.settings.markdown-oxide")
					opts = vim.tbl_deep_extend("force", md_ox_opts, opts.capabilities)

					lspconfig.markdown_oxide.setup(opts)
				end
			}

			handlers.setup()
		end,
	},
}
