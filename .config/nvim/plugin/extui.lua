-- NOTE: cutting edge
if vim.fn.has('nvim-0.12') == 0 then
	return
end

require('vim._core.ui2').enable({
	enable = true, -- Whether to enable or disable the UI.
	msg = { -- Options related to the message module.
		targets = 'msg',
		msg = { -- Options related to msg window.
			timeout = 4000, -- ms
		},
	},
})

vim.cmd.set('fillchars+=msgsep:┄')
