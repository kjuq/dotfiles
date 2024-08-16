local M = {}

---@return boolean
local find_clang_format = function()
	return true
end

local register = function()
	local null_ls = require('null-ls')

	local clang_format = null_ls.builtins.formatting.clang_format
	local confpath = vim.fn.getenv('XDG_CONFIG_HOME') .. '/clang-format'

	clang_format._opts.args = require('null-ls.helpers').range_formatting_args_factory({
		'-assume-filename',
		'$FILENAME',
		'--style=file:' .. confpath,
	}, '--offset', '--length', { use_length = true, row_offset = -1, col_offset = -1 })

	null_ls.register(clang_format)
end

M.setup = register

return M
