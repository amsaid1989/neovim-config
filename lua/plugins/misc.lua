return {
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "Tetralux/odin.vim" },
	{ "tpope/vim-endwise" },
	{
		"jiangmiao/auto-pairs",
		init = function()
			vim.cmd('autocmd FileType c,cpp let b:AutoPairs = AutoPairsDefine({"<": ">"})')
		end
	},
	{ "andymass/vim-matchup" },
	{ "tpope/vim-fugitive" },
}
