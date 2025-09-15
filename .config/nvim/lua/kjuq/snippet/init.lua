---@alias kjuq.snippet.word (fun():string)|string|string[]

---@alias kjuq.snippet.snippet kjuq.snippet.word[]

local M = {}

---@param word kjuq.snippet.word
---@return string
local function create_word(word)
	if type(word) == 'string' then
		return word
	elseif type(word) == 'function' then
		return word()
	elseif type(word) == 'table' then
		return table.concat(word, '\n')
	end
	vim.notify('Invalid word was given', vim.log.levels.WARN)
	return ''
end

-- Called by `setup()`
---@return table<string, kjuq.snippet.word>
local function generate_filetype_snippets()
	local ftsnippets = {}
	ftsnippets.all = require('kjuq.snippet.ft.all').snippets
	local dirpath = vim.fn.stdpath('config') .. '/lua/kjuq/snippet/ft/'
	for filename, fileattr in vim.fs.dir(dirpath) do
		if fileattr == 'file' then
			local filetype = filename:gsub('%.lua$', '')
			ftsnippets[filetype] = require('kjuq.snippet.ft.' .. filetype).snippets
		end
	end
	return ftsnippets
end

---@return kjuq.snippet.snippet[]
local function get_snips_by_ft(filetype)
	local snpft = generate_filetype_snippets()
	local snips = {}
	snips = vim.tbl_deep_extend('error', snips, snpft.all)
	if filetype and snpft[filetype] then
		snips = vim.tbl_deep_extend('error', snips, snpft[filetype])
	end
	return snips
end

---@return kjuq.snippet.snippet[]
local function get_buf_snips()
	return get_snips_by_ft(vim.bo.filetype)
end

function M.select()
	local colpos = vim.api.nvim_win_get_cursor(0)[2] + 1 -- zero-indexed
	local linesize = #vim.api.nvim_get_current_line()
	local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
	local snippets = get_buf_snips()
	local candidates = {}
	for trigger, _ in pairs(snippets) do
		candidates[#candidates + 1] = trigger
	end
	vim.ui.select(candidates, {
		prompt = 'Select snippet:',
		format_item = function(item)
			return item
		end,
	}, function(choice)
		local word = choice and create_word(snippets[choice]) or nil
		if not word then
			if mode == 'n' then
				return
			end
			local opts = (linesize < colpos) and { bang = true } or {}
			vim.cmd.startinsert(opts)
			return
		end
		-- Expand a snippet
		if linesize < colpos then -- At the end of a line
			vim.cmd.startinsert({ bang = true })
		else
			if colpos > 1 then -- At the middle of a line
				vim.api.nvim_feedkeys('l', 'x', true)
			end
			vim.cmd.startinsert()
		end
		vim.snippet.expand(word)
	end)
end

local function generate_complete_item(label, body)
	return {
		-- detail = desc or 'User Snippet',
		label = label,
		kind = vim.lsp.protocol.CompletionItemKind['Snippet'],
		documentation = {
			value = body,
			kind = vim.lsp.protocol.MarkupKind.Markdown,
		},
		insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
		insertText = body,
		sortText = 1.02, -- Ensure a low score by setting a high sortText value, not sure
	}
end

---@return table: A table containing completion results formatted for LSP
local function get_lsp_snippets()
	local completion_results = {
		isIncomplete = false,
		items = {},
	}
	for label, body in pairs(get_buf_snips()) do
		table.insert(completion_results.items, generate_complete_item(label, create_word(body)))
	end
	return completion_results
end

---@return function: A function that creates a new server instance
-- https://gist.github.com/DimitrisDimitropoulos/f8c8b13a50994d30296fc190c8004e60
function M.new_server()
	local function server(dispatchers)
		local closing = false
		local srv = {}
		function srv.request(method, _, handler)
			if method == 'initialize' then
				handler(nil, {
					capabilities = {
						completionProvider = {},
					},
				})
			elseif method == 'textDocument/completion' then
				handler(nil, get_lsp_snippets())
			elseif method == 'shutdown' then
				handler(nil, nil)
			end
		end
		function srv.notify(method, _)
			if method == 'exit' then
				dispatchers.on_exit(0, 15)
			end
		end
		function srv.is_closing()
			return closing
		end
		function srv.terminate()
			closing = true
		end
		return srv
	end
	return server
end
return M
