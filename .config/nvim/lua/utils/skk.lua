local M = {}

M.skk_dir = os.getenv("XDG_CONFIG_HOME") .. "/skk"
M.jisyo_user = M.skk_dir .. "/my_jisyo"

_G._user_skk_jp_mode_enabled = false
local group = vim.api.nvim_create_augroup("user_skk_toggle", {})

---@param callback fun()
M.toggle_japanese = function(callback)
	if _G._user_skk_jp_mode_enabled then
		print("Japanese mode disabled (English)")
		vim.api.nvim_clear_autocmds({ group = group })
	else
		print("Japanese mode enabled (Japanese)")
		vim.api.nvim_create_autocmd("InsertEnter", {
			group = group,
			pattern = "*",
			callback = callback,
		})
	end
	_G._user_skk_jp_mode_enabled = not _G._user_skk_jp_mode_enabled
end

M.mappings = function(desc_prefix, enable, disable, toggle)
	local map = require("utils.lazy").generate_map("", desc_prefix)
	local skk = require("utils.skk")
	local toggle_japanese = function()
		skk.toggle_japanese(function()
			require("utils.common").feed_plug(enable)
		end)
	end

	local map_toggle = function(key)
		return map(key, { "i", "c" }, function()
			require("utils.common").feed_plug(toggle)
		end, "Toggle")
	end

	local map_toggle_jp = function(key)
		return map(key, "n", function()
			toggle_japanese()
		end, "Toggle JP mode")
	end

	local map_enable = function(key)
		return map(key, { "i", "c" }, function()
			require("utils.common").feed_plug(enable)
		end, "Enable")
	end

	local map_disable = function(key)
		return map(key, { "i", "c" }, function()
			require("utils.common").feed_plug(disable)
		end, "Disable")
	end

	local map_toggle_jp_in_insert_mode = function(key)
		return map(key, "i", function()
			if _G._user_skk_jp_mode_enabled then
				require("utils.common").feed_plug(disable)
			else
				require("utils.common").feed_plug(enable)
			end
			toggle_japanese()
		end, "Toggle JP mode")
	end

	return {
		map_toggle("<C-Space>"),
		map_toggle_jp("<leader>aj"),
		map_enable("<C-g>n"),
		map_enable("<C-g><C-n>"),
		map_disable("<C-g>e"),
		map_disable("<C-g><C-e>"),
		map_toggle_jp_in_insert_mode("<C-g>N"),
	}
end

---@return table
return M
