---@type vim.lsp.Config
return {
	name = 'kjuq_snippet_ls',
	cmd = require('kjuq.snippet').new_server(),
}
