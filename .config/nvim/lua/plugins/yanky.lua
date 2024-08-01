local map = require("utils.lazy").generate_map("", "Yanky: ")

---@type LazySpec
local spec = { "gbprod/yanky.nvim" }

spec.event = { "TextYankPost" }

spec.keys = {
	map("p", { "n", "x" }, "<Plug>(YankyPutAfter)", "Put after"),
	map("P", { "n", "x" }, "<Plug>(YankyPutBefore)", "Put before"),
	map("gp", { "n", "x" }, "<Plug>(YankyGPutAfter)", "GPut after"),
	map("gP", { "n", "x" }, "<Plug>(YankyGPutBefore)", "GPut before"),

	map("-", "n", function()
		if require("yanky").can_cycle() then
			return "<Plug>(YankyPreviousEntry)"
		else
			return "-"
		end
	end, "Previous entry", { expr = true }),
	map("+", "n", function()
		if require("yanky").can_cycle() then
			return "<Plug>(YankyNextEntry)"
		else
			return "+"
		end
	end, "Next entry", { expr = true }),

	map("<leader>fp", "n", function()
		local has_telescope, telescope = pcall(require, "telescope")
		if has_telescope then
			telescope.extensions.yank_history.yank_history()
		end
	end, "search with Telescope"),
}

spec.config = function()
	local utils = require("yanky.utils")
	local opts = {
		ring = {
			history_length = 20,
			cancel_event = "move",
		},
		system_clipboard = {
			sync_with_ring = false,
		},
		highlight = {
			on_put = true,
			on_yank = false,
			timer = require("utils.common").highlight_duration,
		},
		picker = {
			select = {
				action = require("yanky.picker").actions.set_register(utils.get_default_register()),
			},
		},
	}

	local has_telescope, telescope = pcall(require, "telescope")
	if has_telescope then
		telescope.load_extension("yank_history")

		local mapping = require("yanky.telescope.mapping")

		opts.picker.telescope = {
			use_default_mappings = false,
			mappings = {
				default = mapping.set_register(utils.get_default_register()),
				i = {
					["<C-x>"] = mapping.delete(),
				},
				n = {
					d = mapping.delete(),
				},
			},
		}
	end

	require("yanky").setup(opts)
end

return spec
