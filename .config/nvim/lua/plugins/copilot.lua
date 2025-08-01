-- To setup `:Copilot auth`

local auto_trigger = false

---@type LazySpec
local spec = { 'https://github.com/zbirenbaum/copilot.lua' }
spec.cmd = 'Copilot'

spec.enabled = vim.fn.executable('node') ~= 0

spec.event = { 'InsertEnter' }

local map = require('kjuq.utils.lazy').generate_map('', 'Copilot: ')
spec.keys = {
	map('<C-a>', 'i', function()
		local cs = require('copilot.suggestion')
		if not cs.is_visible() then
			return
		end
		cs.accept()
	end, 'Accept'),
	map('<C-g><C-a>', 'i', function()
		local cs = require('copilot.suggestion')
		if cs.is_visible() then
			cs.accept()
		else
			cs.next()
			vim.b.copilot_suggestion_auto_trigger = true
		end
	end, 'Start'),
	map('<C-g><C-e>', 'i', function()
		local cs = require('copilot.suggestion')
		if not cs.is_visible() then
			return
		end
		cs.dismiss()
		vim.b.copilot_suggestion_auto_trigger = false
	end, 'Stop'),
	map('<C-e>', 'i', function()
		local cs = require('copilot.suggestion')
		if not cs.is_visible() then
			return '<C-e>'
		end
		cs.accept()
	end, 'Accept', { expr = true }),
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
		debounce = 0,
		keymap = {
			accept = false,
			accept_word = false,
			accept_line = false,
			next = false,
			prev = false,
			dismiss = false,
		},
	},
}

spec.config = function(_, opts)
	vim.b.copilot_suggestion_auto_trigger = auto_trigger
	require('copilot').setup(opts)

	vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
		group = vim.api.nvim_create_augroup('kjuq_copilot_restore_autotrigger', {}),
		callback = function()
			vim.b.copilot_suggestion_auto_trigger = auto_trigger
		end,
	})

	-- local has_cmp, cmp = pcall(require, 'cmp')
	-- if has_cmp then
	-- 	cmp.event:on('menu_opened', function()
	-- 		vim.b.copilot_suggestion_hidden = true
	-- 	end)
	-- 	cmp.event:on('menu_closed', function()
	-- 		vim.b.copilot_suggestion_hidden = false
	-- 	end)
	-- end
end

return spec
