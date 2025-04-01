-- neovim/runtime/lua/vim/lsp.lua > lsp._set_defaults
vim.keymap.set('n', 'gr', '<Nop>')
local vlb = vim.lsp.buf
vim.keymap.set('n', 'grt', vlb.type_definition, { desc = 'LSP: Go to type definition' })
vim.keymap.set('n', 'grd', vlb.declaration, { desc = 'LSP: Go to Declaration' })
vim.keymap.set('n', 'grh', vlb.typehierarchy, { desc = 'LSP: Type hierarchy' })
vim.keymap.set('n', 'grc', vlb.incoming_calls, { desc = 'LSP: Incoming calls' })
vim.keymap.set('n', 'grg', vlb.outgoing_calls, { desc = 'LSP: Outgoing calls' })
vim.keymap.set({ 'n', 'x' }, 'grf', vlb.format, { desc = 'LSP: Format' })
vim.keymap.set('n', '<M-e>', vim.diagnostic.open_float, { desc = 'LSP: Show diagnostics' })
vim.keymap.set('n', 'grwa', vlb.add_workspace_folder, { desc = 'LSP: Add folder to workspace' })
vim.keymap.set('n', 'grwr', vlb.remove_workspace_folder, { desc = 'LSP: Remove folder from workspace' })
vim.keymap.set('n', 'grww', function()
	vim.notify(vim.inspect(vlb.list_workspace_folders()))
end, { desc = 'LSP: List folders of workspaceh' })
vim.keymap.set('n', 'grl', vim.diagnostic.setloclist, { desc = 'LSP: Set diagnostics into loclist' })

local utils = require('kjuq.utils.lsp')

vim.keymap.set({ 'n', 's', 'i' }, '<C-s>', function()
	vim.lsp.buf.signature_help(utils.hover_opts)
end, { desc = 'LSP: Signature Help' })

vim.keymap.set('n', ']d', function()
	vim.diagnostic.jump({
		float = utils.hover_opts,
		count = vim.v.count1,
	})
end, { desc = 'Jump to the next diagnostic in the current buffer' })

vim.keymap.set('n', '[d', function()
	vim.diagnostic.jump({
		float = utils.hover_opts,
		count = -vim.v.count1,
	})
end, { desc = 'Jump to the previous diagnostic in the current buffer' })
