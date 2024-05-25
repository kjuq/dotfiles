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

M.verylazy = { "VeryLazy" }

return M
