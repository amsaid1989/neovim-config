return {
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "Tetralux/odin.vim" },
	{ "tpope/vim-endwise" },
	{ "jiangmiao/auto-pairs" },
	{ "andymass/vim-matchup" },
	{ "tpope/vim-commentary" },
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = "markdown",
	},
}
