local M = {}

M.skk_dir = os.getenv('XDG_CONFIG_HOME') .. '/skk'
M.jisyo_user = M.skk_dir .. '/my_jisyo'
M.completion_rank = M.skk_dir .. '/completion_rank'

local is_skk_jp_mode_enabled = false
local group = vim.api.nvim_create_augroup('kjuq_skk_toggle', {})

function M.is_skk_jp_mode_enabled()
	return is_skk_jp_mode_enabled
end

---@param callback fun()
M.toggle_japanese = function(callback)
	if is_skk_jp_mode_enabled then
		vim.notify('Japanese mode disabled (English)')
		vim.api.nvim_clear_autocmds({ group = group })
	else
		vim.notify('Japanese mode enabled (Japanese)')
		vim.api.nvim_create_autocmd('InsertEnter', {
			group = group,
			pattern = '*',
			callback = callback,
		})
	end
	is_skk_jp_mode_enabled = not is_skk_jp_mode_enabled
end

M.mappings = function(desc_prefix, enable, disable, toggle)
	local _, _ = disable, toggle -- supress unused-local
	local map = require('kjuq.utils.lazy').generate_map('', desc_prefix)
	local skk = require('kjuq.utils.skk')
	local toggle_japanese = function()
		skk.toggle_japanese(function()
			require('kjuq.utils.common').feed_plug(enable)
		end)
	end

	local toggle_jp = function(key)
		return map(key, 'n', function()
			toggle_japanese()
		end, 'Toggle JP mode')
	end

	local enable_tmp = function(key)
		return map(key, { 'i', 'c' }, function()
			require('kjuq.utils.common').feed_plug(enable)
		end, 'Enable')
	end

	local i_jp = function(key)
		return map(key, 'n', function()
			require('kjuq.utils.common').feed_plug(enable)
			return 'i'
		end, '`i` (SKK)', { expr = true })
	end

	local a_jp = function(key)
		return map(key, 'n', function()
			require('kjuq.utils.common').feed_plug(enable)
			return 'a'
		end, '`a` (SKK)', { expr = true })
	end

	local o_jp = function(key)
		return map(key, 'n', function()
			require('kjuq.utils.common').feed_plug(enable)
			return 'o'
		end, '`o` (SKK)', { expr = true })
	end

	local s_jp = function(key)
		return map(key, 'n', function()
			require('kjuq.utils.common').feed_plug(enable)
			return 's'
		end, '`s` (SKK)', { expr = true })
	end

	return {
		enable_tmp('<C-Space>'),
		toggle_jp('<Space>tj'),
		i_jp('<M-i>'),
		a_jp('<M-a>'),
		o_jp('<M-o>'),
		s_jp('c<M-l>'),
	}
end

---@return table
return M
