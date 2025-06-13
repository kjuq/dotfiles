---@type LazySpec
local spec = { 'https://github.com/4513ECHO/nvim-keycastr' }

spec.cmd = {
	'KeycastrEnable',
	'KeycastrDisable',
}

spec.config = function()
	vim.api.nvim_create_user_command('KeycastrEnable', function()
		require('keycastr').enable()
	end, {})
	vim.api.nvim_create_user_command('KeycastrDisable', function()
		require('keycastr').disable()
	end, {})
end

return spec
