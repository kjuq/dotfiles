local manual_mode = false

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/ahmedkhalf/project.nvim' }
spec.name = 'project_nvim'

spec.event = not manual_mode and { 'BufNewFile', 'BufReadPost' } or {}

spec.cmd = {
	'ProjectRoot',
	'AddProject',
}

local map = require('kjuq.utils.lazy').generate_map('', 'Project: ')
spec.keys = {
	map('<Space>a.', 'n', '<Cmd>ProjectRoot<CR>', 'cd <project_root>'),
	map('<Space>fP', 'n', function()
		local has_telescope, telescope = pcall(require, 'telescope')
		if has_telescope then
			telescope.extensions.projects.projects({})
		else
			vim.notify('Telescope is not installed')
		end
	end, 'Pick projects'),
}

spec.opts = {
	manual_mode = manual_mode,
	detection_methods = { 'pattern' },
}

spec.init = function()
	_G.kjuq_init_cwd = vim.fn.getcwd()
end

return spec
