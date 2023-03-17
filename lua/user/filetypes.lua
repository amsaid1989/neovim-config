-- Add support for filetypes not recognised automatically by Neovim

-- Odin
vim.filetype.add({
	pattern = {
		['.*%.odin'] = 'odin'
	}
})
