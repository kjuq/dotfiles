---@type LazySpec
local spec = { 'toppair/peek.nvim' }
spec.build = 'deno task --quiet build:fast'

spec.cmd = {
	'PeekOpen',
	'PeekClose',
	'PeekToggle',
}

local map = require('kjuq.utils.lazy').generate_map('', 'Peek: ')
spec.keys = {
	map('<Space>aP', 'n', '<Cmd>PeekToggle<CR>', 'Toggle'),
}

spec.opts = {}

spec.config = function(_, opts)
	-- webkitgtk has an issue with Nvidia card. See,
	-- https://www.reddit.com/r/EndeavourOS/comments/1bsf8km
	-- https://github.com/tauri-apps/tauri/issues/8462
	vim.fn.setenv('WEBKIT_DISABLE_DMABUF_RENDERER', '1')
	local peek = require('peek')
	peek.setup(opts)
	vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
	vim.api.nvim_create_user_command('PeekClose', peek.close, {})
	vim.api.nvim_create_user_command('PeekToggle', function()
		if peek.is_open() then
			peek.close()
		else
			peek.open()
		end
	end, {})
end

return spec
