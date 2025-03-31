---@param dir string
---@return table?
local listls = function(dir)
	local req, err = vim.uv.fs_scandir(dir)
	if not req then
		error(err)
		return nil
	end
	local result = {}
	while true do
		local name, _ = vim.uv.fs_scandir_next(req)
		if not name then
			break
		end -- no more entries
		local filename = string.gsub(name, [[.lua$]], '')
		result[#result + 1] = filename
	end
	return result
end

-- local all_ls = {'lua_ls', 'clangd', 'pyright', 'ruff', 'markdown-oxide'}
local all_ls = listls(os.getenv('XDG_CONFIG_HOME') .. '/nvim/lsp') or {}

vim.lsp.enable(all_ls)
require('kjuq.utils.lsp').setup()
