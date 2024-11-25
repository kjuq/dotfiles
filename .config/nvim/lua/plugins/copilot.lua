-- To setup `:Copilot auth`

---@type LazySpec
local spec = { 'zbirenbaum/copilot.lua' }
spec.cmd = 'Copilot'

spec.event = { 'InsertEnter' }

local map = require('utils.lazy').generate_map('', 'Copilot: ')
spec.keys = {
	map('<C-g><C-t>', 'i', function()
		local cs = require('copilot.suggestion')
		cs.toggle_auto_trigger()
		if vim.b.copilot_suggestion_auto_trigger then
			cs.next() -- enabled
			vim.notify('Copilot: Auto trigger enabled', vim.log.levels.INFO)
		else
			cs.dismiss() -- disabled
			vim.notify('Copilot: Auto trigger disabled', vim.log.levels.INFO)
		end
	end, 'Toggle auto trigger'),
}

---@type copilot_config
spec.opts = {
	panel = {
		enabled = false,
	},
	suggestion = {
		enabled = true,
		auto_trigger = true, -- `vim.b.copilot_suggestion_auto_trigger` is prioritized
		hide_during_completion = false, -- true and false are reversed?
		debounce = 15,
		keymap = {
			accept = '<C-a>',
			accept_word = false,
			accept_line = '<M-e>',
			next = false,
			prev = false,
			dismiss = '<C-g><C-s>',
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		['.'] = false,
	},
}

spec.config = function(_, opts)
	local has_cmp, cmp = pcall(require, 'cmp')
	if has_cmp then
		cmp.event:on('menu_opened', function()
			vim.b.copilot_suggestion_hidden = true
		end)
		cmp.event:on('menu_closed', function()
			vim.b.copilot_suggestion_hidden = false
		end)
	end
	vim.b.copilot_suggestion_auto_trigger = true
	require('copilot').setup(opts)
end

return spec
