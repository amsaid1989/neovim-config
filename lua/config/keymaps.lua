local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- Switch the keys from Ctrl-w + [h/j/k/l] to Ctrl-[h/j/k/l]
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Open NvimTree with <leader>-e
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Resize the splits with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>db", ":bd!<CR>", opts) -- Close buffer

-- Move text up and down using Alt-[k/j]
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Run MarkdownPreview using Ctrl-Shift-p
keymap("n", "<C-p>", ":MarkdownPreview<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>gf", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>gb", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
keymap("n", "<leader>gl", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>km", "<cmd>Telescope keymaps<CR>", opts)

-- Vim Fugitive
keymap("n", "<leader>gt", ":G<CR>", opts)

-- Fix tabs
keymap("n", "<leader>ft", ":%s/\t/  /g<CR>:noh<CR>:wa<CR>", opts)

-- Insert --

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down using Alt-[k/j]
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- When pasting over a selection in Visual mode, don't overwrite
-- the contents of the register with the contents of the selection
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- Use Ctrl-[h/j/k/l] to navigate in the terminal
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
