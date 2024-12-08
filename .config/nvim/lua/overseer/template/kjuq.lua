---@param dir string
---@return table?
local list_templates = function(dir)
	local req, err = vim.uv.fs_scandir(dir)
	if not req then
		error(err)
		return nil
	end
	local result = {}
	while true do
		local name, type = vim.uv.fs_scandir_next(req)
		if not name then
			break
		end -- no more entries
		if type == 'file' then
			local no_ext = name:match('(.+)%..+$')
			result[#result + 1] = 'kjuq.' .. no_ext
		end
	end
	return result
end

local template_dir = os.getenv('XDG_CONFIG_HOME') .. '/nvim/lua/overseer/template/kjuq'

return list_templates(template_dir)
