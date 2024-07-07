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
			}

			handlers.setup()
		end,
	},
}
