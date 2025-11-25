-- NOTE: Make sure that `webkit2gtk' is installed
-- `pacman -S webkit2gtk`

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/toppair/peek.nvim' }
spec.build = 'deno task --quiet build:fast'

spec.enabled = vim.fn.executable('deno') ~= 0

spec.cmd = {
	'PeekOpen',
	'PeekClose',
	'PeekToggle',
}

local map = require('kjuq.lazy').generate_map('', 'Peek: ')
spec.keys = {
	map('<Space>aP', 'n', function()
		vim.cmd.PeekToggle()
	end, 'Toggle', { ft = ft }),
}

spec.opts = {
	filetype = ft,
}

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
