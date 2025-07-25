-- Add support for filetypes not recognised automatically by Neovim

-- C Header
vim.filetype.add({
  pattern = {
    ['.*%.h'] = 'c'
  }
})

-- Odin
vim.filetype.add({
  pattern = {
    ['.*%.odin'] = 'odin'
  }
})
