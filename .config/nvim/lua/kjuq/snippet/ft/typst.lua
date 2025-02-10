local texsnp = require('kjuq.snippet.module').snippets.new()

texsnp:add('image', {
	[[#figure(]],
	[[	image("${1:PATH}", width: 80%),]],
	[[	caption: []],
	[[		A caption. This is an example text.]],
	[[	],]],
	[[) <${2:LABEL}>]],
})

return texsnp
