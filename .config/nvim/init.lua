if vim.uv.getuid() == 0 then
	vim.notify('Neovim is running as a super user. Loading configurations was skipped.')
	return
end

vim.loader.enable()

require('kjuq.rc.options')
require('kjuq.rc.keymaps')
require('kjuq.rc.lsp')

require('kjuq.rc.lazy')
