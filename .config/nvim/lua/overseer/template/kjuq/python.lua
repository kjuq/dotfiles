return {
	name = 'Python',
	builder = function()
		local file = vim.fn.expand('%:p')
		return {
			cmd = { 'python' },
			args = { file },
			components = { { 'on_output_quickfix', open = true }, 'default' },
		}
	end,
	condition = {
		filetype = { 'python' },
	},
}
