local M = {}

--- @param key_prefix string
--- @param desc_prefix string
M.generate_map = function(key_prefix, desc_prefix)
	--- @param suffix string
	--- @param mode string|table
	--- @param func function|string
	--- @param comment string
	--- @param other_opts table?
	local map = function(suffix, mode, func, comment, other_opts)
		local key = key_prefix .. suffix
		local desc = desc_prefix .. comment

		local result = { key, mode = mode, func, desc = desc }

		if other_opts ~= nil then
			for k, v in pairs(other_opts) do
				result[k] = v
			end
		end

		return result
	end

	return map
end

--- @param key_prefix string
--- @param desc_prefix string
M.generate_cmd_map = function(key_prefix, desc_prefix)
	local map = M.generate_map(key_prefix, desc_prefix)
	--- @param suffix string
	--- @param mode string|table
	--- @param cmd string
	--- @param comment string
	local cmap = function(suffix, mode, cmd, comment)
		return map(suffix, mode, function() vim.cmd(cmd) end, comment)
	end

	return cmap
end

--- @param ft_pattern string|table<string>
M.quit_with_esc = function(ft_pattern)
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = ft_pattern,
		group = vim.api.nvim_create_augroup("user_quit_with_esc", {}),
		callback = function()
			vim.keymap.set("n", "<esc>", vim.cmd.quit, { buffer = true, silent = true })
		end
	})
end

M.verylazy = { "VeryLazy" }
M.floatwinborder = "single"
M.floatscrolldown = "<C-f>"
M.floatscrollup = "<C-b>"

return M
