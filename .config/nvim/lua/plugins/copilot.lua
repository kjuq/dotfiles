---@type LazySpec
local spec = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = { "InsertEnter" },
	opts = function()
		local opts = {
			suggestion = {
				enabled = true,
				auto_trigger = false,
				keymap = {
					accept = false,
					accept_word = false,
					accept_line = false,
					next = "<M-i>",
					prev = false,
					dismiss = false,
				},
			},
			panel = {
				enabled = false,
			},
		}

		local success, cmp = pcall(require, "cmp")
		if success then
			cmp.event:on("menu_opened", function()
				vim.b.copilot_suggestion_hidden = true
			end)

			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end)
		end

		local mod = require("copilot.suggestion")
		--- @param key string
		--- @param normal_behavior function
		--- @param choosing_behavior function
		local map = function(key, normal_behavior, choosing_behavior)
			vim.keymap.set("i", key, function()
				if not mod.is_visible() then
					normal_behavior()
				else
					choosing_behavior()
				end
			end)
		end

		map("<C-f>", mod.next, mod.accept)
		map("<C-l>", function() vim.cmd.fclose { bang = true } end, mod.dismiss)

		if not opts.suggestion.auto_trigger then
			map("<M-f>", function() mod.next() end, function()
				mod.accept_word()
				mod.next()
			end)
			map("<M-n>", function() mod.next() end, function()
				mod.accept_line()
				mod.next()
			end)
		end

		return opts
	end,
}

return spec
