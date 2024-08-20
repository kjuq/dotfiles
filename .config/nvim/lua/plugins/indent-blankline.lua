---@type LazySpec
local spec = { 'lukas-reineke/indent-blankline.nvim' }
spec.main = 'ibl'
spec.event = 'VeryLazy'

spec.config = function()
	-- disable builtin indentline
	vim.opt_local.listchars:remove('leadmultispace')
	vim.api.nvim_clear_autocmds({ group = 'kjuq_init_indent_line' })
	vim.api.nvim_clear_autocmds({ group = 'kjuq_update_indent_line' })

	local highlight = {
		'IndentBlanklineIndent1',
		'IndentBlanklineIndent2',
		'IndentBlanklineIndent3',
		'IndentBlanklineIndent4',
	}

	local hooks = require('ibl.hooks')
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { fg = '#4C566A', nocombine = true })
		vim.api.nvim_set_hl(0, 'IndentBlanklineIndent2', { fg = '#434C5E', nocombine = true })
		vim.api.nvim_set_hl(0, 'IndentBlanklineIndent3', { fg = '#3B4252', nocombine = true })
		vim.api.nvim_set_hl(0, 'IndentBlanklineIndent4', { fg = '#2E3440', nocombine = true })
	end)

	-- hooks.register(hooks.type.SKIP_LINE, function(_, _, _, line)
	-- 	local pattern = "^$" -- empty line
	-- 	return line:match(pattern)
	-- end)
	--
	-- hooks.register(hooks.type.SKIP_LINE, hooks.builtin.skip_preproc_lines, { bufnr = 0 })

	local opts = {
		indent = {
			highlight = highlight,
			char = '╎', -- "╎", "┆","│", "▏",
			tab_char = '│',
		},
		scope = {
			enabled = false,
			show_start = false,
			show_end = false,
		},
		exclude = {
			filetypes = { 'oil', 'undotree' },
		},
	}

	local ibl = require('ibl')
	ibl.setup(opts)
	ibl.refresh_all()
end

return spec
