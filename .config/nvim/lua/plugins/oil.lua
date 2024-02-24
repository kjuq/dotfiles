local map = require("utils.lazy").generate_cmd_map("", "Oil: ")
local hiddens = { ".DS_Store", ".git", ".gitmodules", "node_modules" }

---@type LazySpec
local spec = { "stevearc/oil.nvim" }
spec.lazy = os.getenv("OILSSH") == nil
spec.event = require("utils.lazy").verylazy

spec.keys = {
	map("<leader>i", "n", "Oil", "Open"),
	map("gX", "n", "Oil", "Open"),
}

spec.init = function()
	vim.g.loaded_netrwPlugin = 1
end

spec.opts = {
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	cleanup_delay_ms = 1000,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = "actions.select_vsplit",
		["g<C-s>"] = "actions.select_split",
		["K"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["go"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
	use_default_keymaps = false,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name, _)
			return vim.list_contains(hiddens, name)
		end,
	},
}

spec.dependencies = { "nvim-tree/nvim-web-devicons" }

return spec
