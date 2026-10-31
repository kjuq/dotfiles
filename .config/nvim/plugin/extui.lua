if vim.fn.has('nvim-0.12') == 0 then
	return
end

require('vim._core.ui2').enable({
	enable = true, -- Whether to enable or disable the UI.
	-- timeout = 4000, -- ms
	msg = { -- Options related to the message module.
		targets = 'msg',
	},
})

vim.cmd.set('fillchars+=msgsep:┄')

if vim.fn.has('nvim-0.13') == 0 then
	vim.opt.messagesopt:append({ timeout = 400 })
end
