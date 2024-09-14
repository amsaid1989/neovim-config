local keymap = vim.api.nvim_set_keymap

-- AlignAt command to align several lines at specific character
vim.api.nvim_create_user_command("AlignAt", function(opts)
	if #opts.fargs ~= 1 then
		print("Usage :AlignAt char")
		print("Example :AlignAt =")
		return
	end

	local delim = opts.fargs[1]

	if opts.range > 0 then
		vim.api.nvim_exec2(opts.line1 .. "," .. opts.line2 .. "! column -t -s" .. delim .. " -o" .. delim, {})
	else
		vim.api.nvim_exec2("%! column -t -s" .. delim .. " -o" .. delim, {})
	end
end, { nargs = "*", range = true })

-- AlignAt custom command shortcut
keymap("n", "<leader>al", ":AlignAt ", {})
keymap("v", "<leader>al", ":AlignAt ", {})
