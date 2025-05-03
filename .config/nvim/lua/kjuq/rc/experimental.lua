require('vim._extui').enable({
	enable = true,
	msg = {
		---@type 'box'|'cmd'
		pos = 'box',
		box = {
			timeout = 4000,
		},
	},
})
