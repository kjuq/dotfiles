---@alias snippet_ls.word (fun():string)|string|string[]

---@alias snippet_ls.snippet snippet_ls.word[]

local M = {}

---@param word snippet_ls.word
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
---@return table<string, snippet_ls.word>
local function generate_filetype_snippets()
	local ftsnippets = {}
	ftsnippets.all = require('snippet-ls.ft.all').snippets
	local dirpath = vim.fn.stdpath('config') .. '/lua/kjuq/snippet/ft/'
	for filename, fileattr in vim.fs.dir(dirpath) do
		if fileattr == 'file' then
			local filetype = filename:gsub('%.lua$', '')
			ftsnippets[filetype] = require('snippet-ls.ft.' .. filetype).snippets
		end
	end
	return ftsnippets
end

---@return snippet_ls.snippet[]
local function get_snips_by_ft(filetype)
	local snpft = generate_filetype_snippets()
	local snips = {}
	snips = vim.tbl_deep_extend('error', snips, snpft.all)
	if filetype and snpft[filetype] then
		snips = vim.tbl_deep_extend('error', snips, snpft[filetype])
	end
	return snips
end

---@return snippet_ls.snippet[]
local function get_buf_snips()
	return get_snips_by_ft(vim.bo.filetype)
end

-- A function to select snippets using `vim.ui.select`
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
		-- sortText = 'ZZZZZZZZZ' .. label, -- Omnifunc does not support `sortText`
		filterText = label,
	}
end

---@param params table: The completion parameters from LSP
---@return table: A table containing completion results formatted for LSP
local function get_lsp_snippets(params)
	local completion_results = {
		isIncomplete = false,
		items = {},
	}
	local bufnr = 0
	local col = params.position and params.position.character
	local row = params.position and params.position.line
	if not (col and row) then
		vim.notify('Snippet server could not obtain cursor position', vim.log.levels.ERROR)
		return completion_results
	end

	local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1]
	local before_cursor = line:sub(1, col)

	-- 空行または空白のみの場合は補完候補を返さない
	if before_cursor:match('^%s*$') then
		return completion_results
	end

	-- 最低限のトリガー文字数を設定(例: 2文字以上)
	local minletter = 3
	local trigger_word = before_cursor:match('%w+$') or ''
	if #trigger_word < minletter then
		return completion_results
	end
	for label, body in pairs(get_buf_snips()) do
		table.insert(completion_results.items, generate_complete_item(label, create_word(body)))
	end
	return completion_results
end

---@return function: A function that creates a new server instance
-- https://gist.github.com/DimitrisDimitropoulos/f8c8b13a50994d30296fc190c8004e60
local function new_server()
	local function server(dispatchers)
		local closing = false
		local srv = {}
		function srv.request(method, params, handler)
			if method == 'initialize' then
				handler(nil, {
					capabilities = {
						completionProvider = {},
					},
				})
			elseif method == 'textDocument/completion' then
				handler(nil, get_lsp_snippets(params))
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

local function setup()
	vim.lsp.config('snippet', {
		name = 'kjuq_snippet_ls',
		cmd = new_server(),
	})
	vim.lsp.enable('snippet')
end

setup()

return M
