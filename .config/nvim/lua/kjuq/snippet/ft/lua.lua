local M = {}

M.snippets = {
	{
		trigger = 'autocmd',
		body = {
			[[vim.api.nvim_create_autocmd({ '${1:EVENTS}' }, {]],
			[[	pattern = '${2:*}',]],
			[[	group = vim.api.nvim_create_augroup('${3}', {}),]],
			[[	callback = function()${0}end]],
			[[})]],
		},
	},
	{
		trigger = 'lazy.spec',
		body = {
			[[---@type LazySpec]],
			[[local spec = { '${0}' }]],
			[[]],
			[[local map = require('kjuq.utils.lazy').generate_map('', '')]],
			[[spec.keys = {}]],
			[[]],
			[[spec.opts = {}]],
			[[]],
			[[spec.config = function(_, opts)]],
			[[	require('').setup(opts)]],
			[[end]],
			[[]],
			[[return spec]],
		},
	},
	{
		trigger = 'lazy.keymap',
		body = {
			[[local map = require('kjuq.utils.lazy').generate_map('${1:KEY_PREFIX}', '${2:DESC_PREFIX}')]],
			[[spec.keys = {${0}}]],
		},
	},
	{
		trigger = 'feedkeys',
		body = {
			[[vim.api.nvim_feedkeys('${0}', 'n', true)]],
		},
	},
	{
		trigger = 'feedkeys.escape',
		body = {
			[[vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('${0}', true, false, true), 'n', false)]],
		},
	},
	{
		trigger = 'listdir',
		body = {
			[[---@param dir string]],
			[[---@return table?]],
			[[local listdir = function(dir)]],
			[[	local req, err = vim.uv.fs_scandir(dir)]],
			[[	if not req then]],
			[[		error(err)]],
			[[		return nil]],
			[[	end]],
			[[	local result = {}]],
			[[	while true do]],
			[[		local name, type = vim.uv.fs_scandir_next(req)]],
			[[		if not name then]],
			[[			break]],
			[[		end -- no more entries]],
			[[		local full_path = dir .. '/' .. name]],
			[[		result[#result + 1] = full_path]],
			[[	end]],
			[[	return result]],
			[[end]],
			[[]],
		},
	},
}

return M
