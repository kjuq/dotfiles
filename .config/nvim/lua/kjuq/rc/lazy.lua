if os.getenv('NVIM_NO_USER_PLUGINS') == '1' then
	return
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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

---@type LazyConfig
local opts = {
	defaults = {
		lazy = true,
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
	concurrency = vim.uv.available_parallelism() * 2,
	ui = { border = vim.o.winborder },
	performance = {
		rtp = {
			disabled_plugins = {}, -- disable by `g:loaded_*`
		},
	},
	dev = {
		---@param spec LazyPlugin
		path = function(spec)
			local dir = spec.url:gsub('^http[s]+://', ''):gsub([[.git$]], '')
			return vim.fs.joinpath(os.getenv('GHQ_ROOT'), dir)
		end,
		patterns = { 'kjuq' },
		fallback = true,
	},
}

require('lazy').setup('plugins', opts) -- to load multiple dir https://zenn.dev/sisi0808/articles/36ff184554ddd6

if not os.getenv('KJUQ_NVIM_LOAD_ALL_RUNTIME_PATH') then
	return
end
local library = {
	vim.fs.joinpath(vim.env.VIMRUNTIME, '/lua'),
	vim.fs.joinpath(vim.fn.stdpath('config'), '/lua'),
}
for _, v in pairs(require('lazy.core.config').plugins) do
	library[#library + 1] = vim.fs.joinpath(v.dir, '/lua')
end
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			workspace = {
				library = library,
			},
		},
	},
}
