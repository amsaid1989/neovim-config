return {
	{
		"stevearc/conform.nvim",
		init = function()
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_format = "fallback", range = range })
			end, { range = true })

			vim.api.nvim_set_keymap("n", "<leader>lf", "<cmd>Format<CR>", { noremap = true, silent = true })
		end,
		opts = {
			formatters = {
				black = {
					inherit = true,
					append_args = { "--fast" },
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				yaml = { "prettier" },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			-- If this is set, Conform will run the formatter on save.
			-- It will pass the table to conform.format().
			-- This can also be a function that returns the table.
			-- format_on_save = {
			-- 	-- I recommend these options. See :help conform.format for details.
			-- 	lsp_format = "fallback",
			-- 	timeout_ms = 500,
			-- },
			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.INFO,
			-- Conform will notify you when a formatter errors
			notify_on_error = true,
		},
	},
}

