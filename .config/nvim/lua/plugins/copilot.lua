-- To setup `:Copilot auth`

---@type LazySpec
local spec = { 'zbirenbaum/copilot.lua' }
spec.cmd = 'Copilot'
spec.event = { 'InsertEnter' }

spec.opts = function()
	local success, cmp = pcall(require, 'cmp')
	if success then
		cmp.event:on('menu_opened', function()
			vim.b.copilot_suggestion_hidden = true
		end)

		cmp.event:on('menu_closed', function()
			vim.b.copilot_suggestion_hidden = false
		end)
	end

	return {
		panel = { enabled = false },
		suggestion = { enabled = false },
	}
end

return spec
