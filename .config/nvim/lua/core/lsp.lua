-- TODO: use this
-- local methods = require('vim.lsp.protocol').Methods

local M = {}

local vt = false -- if virtual text of diagnostics is on

local virtual_text = function(enabled)
	if enabled then
		return {
			format = function(diagnostic)
				return string.format('%s (%s) [%s]', diagnostic.message, diagnostic.source, diagnostic.code)
			end,
		}
	else
		return false
	end
end

local executed = false
local delete_default_keymaps = function()
	if executed then
		return
	end

	-- rename, code action, reference, and signature help are defined at vim/_defaults.lua
	vim.keymap.del('n', 'grn')
	vim.keymap.del({ 'n', 'x' }, 'gra')
	vim.keymap.del('n', 'grr')
	vim.keymap.del('i', '<C-s>')

	vim.keymap.del('n', ']d')
	vim.keymap.del('n', '[d')
	vim.keymap.del('n', ']D')
	vim.keymap.del('n', '[D')

	vim.keymap.del('n', '<C-w>d')
	vim.keymap.del('n', '<C-w><C-d>')

	executed = true
end

local on_attach = function(ev)
	local bufnr = ev.buf
	-- Keymaps for LSP
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = bufnr })
	end

	local vlb = vim.lsp.buf

	if not require('utils.common').is_keymap_set('gd', 'n') then
		map('n', 'gd', vlb.definition, 'Go to definition')
	end

	delete_default_keymaps()

	map('n', 'gr', '<Nop>')

	map('n', 'grn', vim.lsp.buf.rename, 'Rename')
	map({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, 'Code action')
	map('n', 'grr', vim.lsp.buf.references, 'Go to references')

	map('n', 'grt', vlb.type_definition, 'Go to type definition')
	map('n', 'gri', vlb.implementation, 'Go to implementation')
	map('n', 'grd', vlb.declaration, 'Go to Declaration')

	map('n', 'grh', vlb.typehierarchy, 'Type hierarchy')
	map('n', 'grc', vlb.incoming_calls, 'Incoming calls')
	map('n', 'grg', vlb.outgoing_calls, 'Outgoing calls')
	map('n', 'grf', vlb.format, 'Format')

	map({ 'n', 'i' }, '<C-s>', vlb.signature_help, 'Signature help') -- _defaults.lua only defines imap

	map('n', '<M-e>', vim.diagnostic.open_float, 'Show diagnostics')
	map('n', 'gre', vim.diagnostic.open_float, 'Show diagnostics')

	map('n', 'grwa', vlb.add_workspace_folder, 'Add folder to workspace')
	map('n', 'grwr', vlb.remove_workspace_folder, 'Remove folder from workspace')
	map('n', 'grww', function()
		vim.notify(vim.inspect(vlb.list_workspace_folders()))
	end, 'List folders of workspaceh')

	-- Diagnostics
	map('n', 'grl', vim.diagnostic.setloclist, 'Set diagnostics into loclist')

	if vim.fn.has('nvim-0.11') == 1 then
		map('n', '[e', function()
			vim.diagnostic.jump({ count = -vim.v.count1, float = true })
		end, 'Go to prev diagnostics')
		map('n', ']e', function()
			vim.diagnostic.jump({ count = vim.v.count1, float = true })
		end, 'Go to next diagnostics')
	else
		map('n', '[e', function()
			vim.diagnostic.goto_prev()
		end, 'Go to prev diagnostics')
		map('n', ']e', function()
			vim.diagnostic.goto_next()
		end, 'Go to next diagnostics')
	end

	map('n', 'grv', function()
		vt = not vt
		vim.diagnostic.config({ virtual_text = virtual_text(vt) })
	end, 'Toggle virtual text of diagnotics')

	-- Format on save
	local client_id = ev.data.client_id
	local client = vim.lsp.get_client_by_id(client_id)
	if client and client.supports_method('textDocument/formatting') then
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = vim.api.nvim_create_augroup('kjuq_auto_formatting', { clear = false }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false, id = client_id })
			end,
		})
	end
end

local callback = function(ev)
	-- execute AFTER `on_attach` of each clients
	vim.schedule(function()
		on_attach(ev)
	end)
end

M.float_max_width = 80
M.float_max_height = 20

M._handlers = { -- disable this if you prefer noice-hover-scroll
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
		title = ' Lsp: Hover ',
		border = require('utils.common').floatwinborder,
		max_width = M.float_max_width,
		max_height = M.float_max_height,
	}),
	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		title = ' Lsp: Signature Help ',
		border = require('utils.common').floatwinborder,
		max_width = M.float_max_width,
		max_height = M.float_max_height,
	}),
}

M.setup = function()
	vim.diagnostic.config({
		signs = false,
		virtual_text = virtual_text(vt),
		float = {
			max_width = M.float_max_width,
			max_height = M.float_max_height,
			border = require('utils.common').floatwinborder,
			-- header = false,
			format = function(diagnostic)
				return string.format('%s\n⊳ %s', diagnostic.message, diagnostic.source)
			end,
		},
	})
	vim.api.nvim_create_autocmd('LspAttach', {
		pattern = '*',
		group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
		callback = callback,
	})
end

return M
