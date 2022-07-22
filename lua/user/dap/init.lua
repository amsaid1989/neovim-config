-- Setup debug keymaps
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<F5>", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<F12>", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", ":lua require('dap').toggle_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>ro", ":lua require('dap').repl_open()<CR>", opts)
keymap("n", "<leader>rl", ":lua require('dap').run_last()<CR>", opts)

-- Load extensions
require 'user.dap.dapui'

-- Load the debug adapters' configurations
require 'user.dap.cppdbg'
