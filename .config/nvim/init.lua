if vim.uv.getuid() == 0 then
	vim.notify('Neovim is running as a super user. Loading configurations was skipped.')
	return
end

vim.loader.enable()

local function loadlocalconf(name)
	local myvimrc = os.getenv('MYVIMRC')
	if not myvimrc then
		vim.notify("'MYVIMRC' is not set", vim.log.levels.ERROR)
		return
	end
	local path = vim.fs.joinpath(vim.fn.fnamemodify(myvimrc, ':p:h'), 'lua', 'kjuq', 'rc', 'local', name .. '.lua')
	if not vim.uv.fs_stat(path) then
		return -- skip if the local conf file does not exist
	end
	require('kjuq.rc.local.' .. name)
end

loadlocalconf('initpre')

require('kjuq.rc.general')
require('kjuq.rc.options')
require('kjuq.rc.keymaps')
require('kjuq.rc.commands')
require('kjuq.rc.mouse')
require('kjuq.rc.colorscheme')
require('kjuq.rc.experimental')
require('kjuq.rc.internal_plugin')
require('kjuq.rc.lsp')

loadlocalconf('pluginpre')

require('kjuq.rc.lazy')

loadlocalconf('initpost')
