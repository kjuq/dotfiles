local allsnp = require('kjuq.snippet.module').snippets.new()

allsnp:add('^date', function()
	return os.date('%Y-%m-%d') --[[@ as string]]
end)

allsnp:add('^time', function()
	return os.date('%H:%M:%S') --[[@ as string]]
end)

allsnp:add('shebang', [[#!/usr/bin/env ${0}]])

return allsnp
