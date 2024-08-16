-- TODO: It is not supported to opening multiple projects that uses different .clang-format

local M = {}

---@return string?
--- returns `nil` when `.clang-format` was not found
local find_clang_format = function()
	return require('utils.common').parent_directory_traversal('.clang-format', vim.uv.cwd())
end

local register = function()
	local null_ls = require('null-ls')
	local clang_format = null_ls.builtins.formatting.clang_format

	local fallback_path = vim.fn.getenv('XDG_CONFIG_HOME') .. '/clang-format'

	---@type string?
	local style_flag = '--style=file:' .. fallback_path

	if find_clang_format() then
		style_flag = nil
	end

	clang_format._opts.args = require('null-ls.helpers').range_formatting_args_factory({
		'-assume-filename',
		'$FILENAME',
		style_flag,
	}, '--offset', '--length', { use_length = true, row_offset = -1, col_offset = -1 })

	null_ls.register(clang_format)
end

M.setup = register

return M
