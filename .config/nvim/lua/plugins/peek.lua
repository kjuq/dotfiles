-- NOTE: Make sure that `webkit2gtk' is installed
-- `pacman -S webkit2gtk`

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
		if name ~= 'peek.nvim' then
			return
		end
		if kind ~= 'install' and kind ~= 'update' then
			return
		end
		vim.system({ 'deno', 'task', '--quiet', 'build:fast' }, { cwd = path }):wait()
	end,
})

vim.pack.add({ 'https://github.com/toppair/peek.nvim' })

-- webkitgtk has an issue with Nvidia card. See,
-- https://www.reddit.com/r/EndeavourOS/comments/1bsf8km
-- https://github.com/tauri-apps/tauri/issues/8462
vim.fn.setenv('WEBKIT_DISABLE_DMABUF_RENDERER', '1')

local peek = require('peek')

peek.setup()

vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
vim.api.nvim_create_user_command('PeekClose', peek.close, {})
vim.api.nvim_create_user_command('PeekToggle', function()
	if peek.is_open() then
		peek.close()
	else
		peek.open()
	end
end, {})

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = 'markdown',
	group = vim.api.nvim_create_augroup('kjuq_peek_keymap', {}),
	callback = function()
		vim.keymap.set('n', '<Space>aP', '<Cmd>PeekToggle<CR>', { desc = 'Peek: Toggle', buffer = true })
	end,
})
