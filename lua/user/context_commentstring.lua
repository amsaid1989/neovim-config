local status_ok, commentstring = pcall(require, "ts_context_commentstring")
if not status_ok then
	return
end

commentstring.setup {
	enable = true,
	config = {
		c = { __default = '// %s', __multiline = '// %s' },
		cpp = { __default = '// %s', __multiline = '// %s' },
		zig = { __default = '// %s', __multiline = '// %s' },
		typescript = { __default = '// %s', __multiline = '// %s' },
		javascript = { __default = '// %s', __multiline = '// %s' }
	}
}
