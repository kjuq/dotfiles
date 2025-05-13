require('vim._extui').enable({
	enable = true,
	msg = {
		---@type 'box'|'cmd'
		pos = 'box',
		box = {
			timeout = 6000, -- ms
		},
	},
})

vim.notify = function(msg, level, opts)
	local hl_group = opts and opts.hl_group or nil
	if not hl_group then
		hl_group = level == vim.log.levels.WARN and 'WarningMsg' or nil
	end
	local chunks = { { msg, hl_group } }
	vim.api.nvim_echo(chunks, true, { err = level == vim.log.levels.ERROR })
end
