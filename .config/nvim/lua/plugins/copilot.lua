-- To setup `:Copilot auth`

---@type LazySpec
local spec = { 'zbirenbaum/copilot.lua' }
spec.cmd = 'Copilot'

spec.event = { 'InsertEnter' }

local map = require('utils.lazy').generate_map('', 'Copilot: ')
spec.keys = {
	map('<C-a>', 'i', function()
		local cs = require('copilot.suggestion')
		if cs.is_visible() then
			cs.accept()
		else
			cs.next()
			vim.b.copilot_suggestion_auto_trigger = true
		end
	end, 'Accept suggestion'),
	map('<C-e>', 'i', function()
		local cs = require('copilot.suggestion')
		if cs.is_visible() then
			cs.dismiss()
			vim.b.copilot_suggestion_auto_trigger = false
		else
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-e>', true, false, true), 'n', false)
		end
	end, 'Dismiss suggestion'),
	map('<leader>aA', 'n', function()
		local cs = require('copilot.suggestion')
		cs.toggle_auto_trigger()
		if vim.b.copilot_suggestion_auto_trigger then
			vim.notify('Copilot: Auto trigger enabled', vim.log.levels.INFO)
		else
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
	vim.b.copilot_suggestion_auto_trigger = false
	require('copilot').setup(opts)

	local auto_trigger_bak = vim.b.copilot_suggestion_auto_trigger
	vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
		group = vim.api.nvim_create_augroup('kjuq_copilot_remember_autotrigger', {}),
		callback = function()
			auto_trigger_bak = vim.b.copilot_suggestion_auto_trigger
		end,
	})
	vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
		group = vim.api.nvim_create_augroup('kjuq_copilot_restore_autotrigger', {}),
		callback = function()
			vim.b.copilot_suggestion_auto_trigger = auto_trigger_bak
		end,
	})

	local has_cmp, cmp = pcall(require, 'cmp')
	if has_cmp then
		cmp.event:on('menu_opened', function()
			vim.b.copilot_suggestion_hidden = true
		end)
		cmp.event:on('menu_closed', function()
			vim.b.copilot_suggestion_hidden = false
		end)
	end
end

return spec
