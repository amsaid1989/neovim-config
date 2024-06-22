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
		"odin",
		"tsx",
		"rust",
		"vim",
		"vimdoc",
		"lua",
		"zig"
	},
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,        -- false will disable the whole extension
		-- disable = { "" },                   -- list of language that will be disabled
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 * 1024 -- 1 MB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml", "python" } },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 5000, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
}
