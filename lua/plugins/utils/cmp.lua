return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")

			local kind_icons = {
				Text = "",
				Method = "m",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "",
				Interface = "",
				Module = "",
				Property = "",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-e>"] = cmp.mapping {
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					},
					["<CR>"] = cmp.mapping.confirm { select = true },
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif vim.fn["vsnip#expandable()"]() then
							vim.fn["vsnip-expand"]()
						elseif vim.fn["vsnip#available(1)"]() then
							vim.fn["vsnip-expand-or-jump"]()
						elseif vim.fn["vsnip#jumpable(1)"]() then
							vim.fn["vsnip-jump-next"]()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif vim.fn["vsnip#expandable()"]() then
							vim.fn["vsnip-expand"]()
						elseif vim.fn["vsnip#available(1)"]() then
							vim.fn["vsnip-expand-or-jump"]()
						elseif vim.fn["vsnip#jumpable(-1)"]() then
							vim.fn["vsnip-jump-prev"]()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						-- Kind icons
						vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							vsnip = "[Snippet]",
							buffer = "[Buffer]",
						})[entry.source.name]
						return vim_item
					end,
				},
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' },
					{ name = 'buffer' },
				}),
				experimental = {
					ghost_text = false,
					native_menu = false,
				},
			})
		end,
	},
}
