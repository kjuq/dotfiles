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

-- `:help complete-items`
---@param snippets kjuq.snippet.snippet[]
---@return vim.v.completed_item[]
local function generate_complete_items(snippets)
	local cmpitems = {}
	for trigger, body in pairs(snippets) do
		cmpitems[#cmpitems + 1] = {
			abbr = trigger,
			word = '',
			info = create_word(body),
			empty = true,
			dup = true,
		}
	end
	return cmpitems
end

local snpft = {}
-- Called by `setup()`
local function generate_filetype_snippets()
	snpft.all = require('kjuq.snippet.ft.all').snippets
	local dirpath = vim.fn.stdpath('config') .. '/lua/kjuq/snippet/ft/'
	for filename, fileattr in vim.fs.dir(dirpath) do
		if fileattr == 'file' then
			local filetype = filename:gsub('%.lua$', '')
			snpft[filetype] = require('kjuq.snippet.ft.' .. filetype).snippets
		end
	end
end

---@return kjuq.snippet.snippet[]
local function get_snips_by_ft(filetype)
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

---@diagnostic disable-next-line: duplicate-set-field
function _G.kjuq_complete_snippets(findstart, base)
	if findstart == 1 then
		-- 補完を開始する列番号を見つける
		local line = vim.api.nvim_get_current_line()
		-- カーソル位置の列番号（0ベース）を取得
		local start_col = vim.api.nvim_win_get_cursor(0)[2]
		-- カーソル位置から後方に向かって単語の開始位置を探索
		while start_col > 0 and line:sub(start_col, start_col):match('%a') do
			start_col = start_col - 1
		end
		return start_col
	else
		-- 一致する候補を返す
		local matches = {}
		local snippets = generate_complete_items(get_buf_snips())
		for _, snippet in ipairs(snippets) do
			local abbr = type(snippet) == 'table' and snippet.abbr or snippet --[[@ as string]]
			-- 'base'で始まるプレフィックスを検索
			if abbr:lower():find(base, 1, true) == 1 then
				table.insert(matches, snippet)
			end
		end
		return matches
	end
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

---@class kjuq.snippet.config
---@field key string

---@param opts? kjuq.snippet.config
function M.setup(opts)
	generate_filetype_snippets()
	local key = opts and opts.key or '<C-p>'
	vim.keymap.set('i', key, function()
		local completefunc_bak = vim.o.completefunc
		vim.opt.completefunc = 'v:lua._G.kjuq_complete_snippets'
		vim.api.nvim_create_autocmd({ 'CompleteDonePre' }, {
			group = vim.api.nvim_create_augroup('kjuq_snippet_completion', {}),
			callback = function()
				vim.opt.completefunc = completefunc_bak
			end,
			once = true,
		})
		return '<C-x><C-u>'
	end, { expr = true })
	-- グローバル変数に最後に補完した単語を保存する例
	vim.api.nvim_create_autocmd('CompleteDone', {
		pattern = '*',
		callback = function()
			-- v:completed_item は補完が完了した項目の辞書
			-- ユーザーが何も選択せずに補完を中断した場合は空になるのでチェックする
			-- NOTE: ただし候補を選択してから <Esc> で抜けるとスニペットが展開されてしまうので注意
			local completed_item = vim.v.completed_item
			if completed_item and completed_item.info and completed_item.info ~= '' then
				vim.snippet.expand(completed_item.info)
			end
		end,
	})
end

return M
