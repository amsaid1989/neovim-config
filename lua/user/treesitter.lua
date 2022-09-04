local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup {
	ensure_installed = {
		"c",
		"cpp",
		"css",
		"json",
		"javascript",
		"typescript",
		"python",
		"bash",
		"fish",
		"glsl",
		"gdscript",
		"html",
		"make",
		"cmake",
		"markdown",
		"markdown_inline",
		"tsx",
		"rust",
		"vim"
	},
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml", "python" } },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	context_commentstring = {
		enable = true,
		config = {
			c = { __default = '// %s', __multiline = '// %s' },
			cpp = { __default = '// %s', __multiline = '// %s' },
			typescript = { __default = '// %s', __multiline = '// %s' },
			javascript = { __default = '// %s', __multiline = '// %s' }
		}
	}
}
