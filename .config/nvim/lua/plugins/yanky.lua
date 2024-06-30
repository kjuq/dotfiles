local map = require("utils.lazy").generate_map("", "Yanky: ")

local edgemotion_installed = vim.fn.isdirectory(vim.fn.stdpath("data") .. "/lazy/vim-edgemotion") == 1

---@type LazySpec
local spec = { "gbprod/yanky.nvim" }

spec.keys = {
	map("p", { "n", "x" }, "<Plug>(YankyPutAfter)", "Put after"),
	map("P", { "n", "x" }, "<Plug>(YankyPutBefore)", "Put before"),
	map("gp", { "n", "x" }, "<Plug>(YankyGPutAfter)", "GPut after"),
	map("gP", { "n", "x" }, "<Plug>(YankyGPutBefore)", "GPut before"),

	map("<C-p>", "n", function()
		if require("yanky").can_cycle() then
			return "<Plug>(YankyPreviousEntry)"
		elseif edgemotion_installed then
			return "<Plug>(edgemotion-k)"
		else
			return "<C-p>"
		end
	end, "Previous entry", { expr = true }),
	map("<C-n>", "n", function()
		if require("yanky").can_cycle() then
			return "<Plug>(YankyNextEntry)"
		elseif edgemotion_installed then
			return "<Plug>(edgemotion-j)"
		else
			return "<C-n>"
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
		},
		system_clipboard = {
			sync_with_ring = false,
		},
		highlight = {
			on_put = true,
			on_yank = false,
			timer = 125,
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

spec.dependencies = {
	"haya14busa/vim-edgemotion", -- Because both of Yanky and Edgemotion use <C-p> and <C-n>
}

return spec
