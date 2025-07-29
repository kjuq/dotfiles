-- NOTE: cutting edge
if vim.fn.has('nvim-0.12') == 0 then
	return
end

require('vim._extui').enable({
	enable = true,
	msg = {
		---@type 'cmd'|'msg'
		target = 'msg',
		timeout = 1500, -- ms
	},
})
