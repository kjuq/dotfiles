local M = {}

M.snippets = {
	{
		trigger = 'image',
		body = {
			[[#figure(]],
			[[	image("${1:PATH}", width: 80%),]],
			[[	caption: []],
			[[		A caption. This is an example text.]],
			[[	],]],
			[[) <${2:LABEL}>]],
		},
	},
}

return M
