local M = {}

local success
success, M.capabilities = pcall(function() require("cmp_nvim_lsp").default_capabilities() end)
if not success then
	M.capabilities = nil
end

local max_width = 70
local max_height = 20

M._handlers = { -- disable this if you prefer noice-hover-scroll
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		title = " Lsp: Hover ",
		border = require("utils.lazy").floatwinborder,
		_max_width = max_width,
		_max_height = max_height,
	}),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		title = " Lsp: Signature Help ",
		border = require("utils.lazy").floatwinborder,
		_max_width = max_width,
		_max_height = max_height,
	}),
}

return M
