if os.getenv('NVIM_NO_USER_PLUGINS') == '1' then
	return
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true,
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
	ui = { border = require('utils.common').floatwinborder },
	performance = {
		rtp = {
			disabled_plugins = { -- shorten start up time for 1 ms
				'gzip',
				'matchit',
				'matchparen',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
	dev = {
		path = '~/codes/_nvim_plugins',
		patterns = { 'kjuq' },
		fallback = true,
	},
}

require('lazy').setup('plugins', opts) -- to load multiple dir https://zenn.dev/sisi0808/articles/36ff184554ddd6

vim.keymap.set('n', '<leader>ap', '<Cmd>Lazy<CR>', { desc = 'Lazy.nvim: Manage plugins' })
