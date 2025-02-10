-- https://www.reddit.com/r/neovim/comments/1cxfhom/builtin_snippets_so_good_i_removed_luasnip

local M = {}

local ft = require('kjuq.snippet.ft')

function M.register_cmp_source()
	local cmp_source = {}
	local cache = {}
	function cmp_source.complete(_, _, callback)
		local bufnr = vim.api.nvim_get_current_buf()
		if not cache[bufnr] then
			local completion_items = vim.tbl_map(function(s)
				---@type string
				local body
				if type(s.body) == 'function' then
					body = s.body()
				elseif type(s.body) == 'table' then
					body = table.concat(s.body, '\n')
				else
					body = s.body
				end
				---@type lsp.CompletionItem
				local item = {
					word = s.trigger,
					label = s.trigger,
					kind = vim.lsp.protocol.CompletionItemKind.Snippet,
					insertText = body,
					insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
				}
				return item
			end, ft.get_buf_snips())

			cache[bufnr] = completion_items
		end

		callback(cache[bufnr])
	end

	require('cmp').register_source('kjuq_snippet', cmp_source)
end

return M
