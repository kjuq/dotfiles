local map = require('kjuq.utils.lazy').generate_map('<Space>a', 'Dadbod: ')

---@type LazySpec
local spec = { 'kristijanhusak/vim-dadbod-ui' }

spec.cmd = {
	'DBUI',
	'DBUIToggle',
	'DBUIAddConnection',
	'DBUIFindBuffer',
}

spec.keys = {
	map('D', 'n', '<CMD>DBUIToggle<CR>', 'Open UI'),
}

spec.init = function()
	vim.g.db_ui_use_nerd_fonts = 1
	vim.g.db_ui_save_location = os.getenv('XDG_CONFIG_HOME') .. '/dadbod'
	vim.g.db_ui_force_echo_notifications = 1
	vim.g.db_ui_show_help = 0
end

spec.dependencies = {
	{
		'tpope/vim-dadbod',
		cmd = 'DB',
	},
	{
		'kristijanhusak/vim-dadbod-completion',
		config = function()
			vim.api.nvim_create_autocmd({ 'FileType' }, {
				pattern = { 'sql', 'mysql', 'plsql' },
				callback = function()
					require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
				end,
			})
		end,
	},
}

return spec
