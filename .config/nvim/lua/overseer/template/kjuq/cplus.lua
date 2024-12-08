return {
	name = 'cplus command',
	builder = function()
		local file = vim.fn.expand('%:p')
		return {
			cmd = { 'cplus' },
			args = { file },
			components = { { 'on_output_quickfix', open = true }, 'default' },
		}
	end,
	condition = {
		filetype = { 'cpp' },
	},
}
