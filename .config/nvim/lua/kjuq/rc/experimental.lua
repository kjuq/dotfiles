-- NOTE: cutting edge
if not vim.fn.has('nvim-0.12') then
	return
end

require('vim._extui').enable({
	enable = true,
	msg = {
		---@type 'cmd'|'msg'
		target = 'msg',
		timeout = 6000, -- ms
	},
})
