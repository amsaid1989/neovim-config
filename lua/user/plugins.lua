local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use. A protected
-- call checks if the command called completed successfully
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	-- Essentials
	use "wbthomason/packer.nvim" -- Have packer manage itself
	use "nvim-lua/popup.nvim"   -- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
	use "Tetralux/odin.vim"

	-- General
	use "tpope/vim-endwise"                                                                 -- A simple plugin that helps to end certain structures automatically
	use "jiangmiao/auto-pairs"                                                              -- Insert or delete brackets, parens, quotes in pair
	use 'andymass/vim-matchup'                                                              -- Highlight, navigate, and operate on sets of matching text. It extends vim's % key to language-specific words instead of just single characters
	use 'tpope/vim-commentary'
	use { 'tpope/vim-dispatch', opt = true, cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } } -- Kick off builds and test suites using one of several asynchronous adapters
	use 'tpope/vim-fugitive'
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },
	})
	use { 'nvim-tree/nvim-web-devicons' }
	use { 'nvim-lualine/lualine.nvim' }
	use 'akinsho/bufferline.nvim'
	use 'akinsho/toggleterm.nvim'

	-- Themes
	use 'navarasu/onedark.nvim'
	use 'EdenEast/nightfox.nvim'
	use { 'uloco/bluloco.nvim', requires = { 'rktjmp/lush.nvim' } }

	-- LSP
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}
	-- END LSP

	use { "ms-jpq/coq_nvim", branch = "coq" }
	use { "ms-jpq/coq.artifacts", branch = "artifacts" }
	use { 'ms-jpq/coq.thirdparty', branch = "3p" }

	-- DAP (Debugging)
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

	-- Telescope
	use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
	use { 'nvim-telescope/telescope-media-files.nvim' } -- Media files extension

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }
	use { 'p00f/nvim-ts-rainbow' }                       -- Rainbow parentheses using Treesitter
	use { 'JoosepAlviste/nvim-ts-context-commentstring' } -- Commenting plugin for files that have different languages (e.g. ts/tsx)

	-- Gitsigns
	use 'lewis6991/gitsigns.nvim'

	-- Nvim-Tree
	use { 'nvim-tree/nvim-tree.lua' }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
