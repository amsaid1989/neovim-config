return {
	"ms-jpq/coq_nvim",
	branch = "coq",
	lazy = false,
	dependencies = {
		{ "ms-jpq/coq.artifacts",  branch = "artifacts" },
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
	},
	init = function()
		vim.g.coq_settings = {
			auto_start = 'shut-up',
			keymap = {
				recommended = true,
				jump_to_mark = '<c-a>',
			},
			completion = {
				replace_suffix_threshold = 0,
			}
		}
	end,
}
