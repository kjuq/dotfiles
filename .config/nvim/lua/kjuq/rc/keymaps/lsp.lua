-- neovim/runtime/lua/vim/lsp.lua > lsp._set_defaults
vim.keymap.set('n', 'gr', '<Nop>')
local vlb = vim.lsp.buf
vim.keymap.set('n', 'grt', vlb.type_definition, { desc = 'LSP: Go to type definition' })
vim.keymap.set('n', 'gri', vlb.implementation, { desc = 'LSP: Go to implementation' })
vim.keymap.set('n', 'grd', vlb.declaration, { desc = 'LSP: Go to Declaration' })
vim.keymap.set('n', 'grh', vlb.typehierarchy, { desc = 'LSP: Type hierarchy' })
vim.keymap.set('n', 'grc', vlb.incoming_calls, { desc = 'LSP: Incoming calls' })
vim.keymap.set('n', 'grg', vlb.outgoing_calls, { desc = 'LSP: Outgoing calls' })
vim.keymap.set('n', 'grf', vlb.format, { desc = 'LSP: Format' })
vim.keymap.set('n', '<M-e>', vim.diagnostic.open_float, { desc = 'LSP: Show diagnostics' })
vim.keymap.set('n', 'grwa', vlb.add_workspace_folder, { desc = 'LSP: Add folder to workspace' })
vim.keymap.set('n', 'grwr', vlb.remove_workspace_folder, { desc = 'LSP: Remove folder from workspace' })
vim.keymap.set('n', 'grww', function()
	vim.notify(vim.inspect(vlb.list_workspace_folders()))
end, { desc = 'LSP: List folders of workspaceh' })
vim.keymap.set('n', 'grl', vim.diagnostic.setloclist, { desc = 'LSP: Set diagnostics into loclist' })

vim.keymap.set({ 'n', 's', 'i' }, '<C-s>', function()
	vim.lsp.buf.signature_help({
		title = ' Lsp: Signature Help ',
		border = require('kjuq.utils.common').floatwinborder,
		max_width = require('kjuq.utils.lsp').float_max_width,
		max_height = require('kjuq.utils.lsp').float_max_height,
	})
end, { desc = 'LSP: Signature Help' })
