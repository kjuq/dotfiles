-- NOTE: cutting edge
if not vim.fn.has('nvim-0.12') then
	return
end

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
