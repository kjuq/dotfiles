_G.kjuq = {}

if vim.uv.getuid() == 0 then
	vim.notify('Neovim is running as a super user. Loading configurations was skipped.')
	return
end

vim.loader.enable()

local localconfexists, localconf = pcall(require, 'kjuq.local')

if localconfexists and localconf.pre then
	localconf.pre()
end

require('kjuq.rc.option')
require('kjuq.rc.keymap')
require('kjuq.rc.lsp')

require('plugins')

if localconfexists and localconf.post then
	localconf.post()
end

-- vim: set foldmethod=marker :
