---@alias AsteriskKeys '*'|'#'|'g*'|'g#'

---@return boolean
local is_focusing_search_word = function()
	local cword = vim.fn.expand('<cword>')
	local last_pat = vim.fn.getreg('/')
	return vim.v.hlsearch == 1 and vim.fn.match(cword, last_pat) ~= -1
end

---@param key AsteriskKeys
---@return boolean
local search_forward = function(key)
	assert(key == '*' or key == '#' or key == 'g*' or key == 'g#')
	return key == '*' or key == 'g*'
end

---@param key AsteriskKeys
local function normal_search(key)
	assert(key == '*' or key == '#' or key == 'g*' or key == 'g#')
	-- To deal with v:count1, this function uses `:normal` command
	-- rather than returning a key sequence along with `{ expr = true }`
	if vim.fn.expand('<cword>') == '' then
		return
	end
	if is_focusing_search_word() then
		vim.v.searchforward = search_forward(key) and 1 or 0
		vim.cmd([[:silent! :normal! ]] .. vim.v.count1 .. 'n')
	else
		local search ---@type string
		if key == '*' or key == '#' then
			search = [[\<]] .. vim.fn.expand('<cword>') .. [[\>]]
		else
			search = vim.fn.expand('<cword>')
		end
		vim.fn.setreg('/', search)
		vim.fn.histadd('/', search)
		vim.v.searchforward = search_forward(key) and 1 or 0
		vim.v.hlsearch = true
		if vim.v.count1 ~= 1 then
			vim.cmd([[:silent! :normal! ]] .. vim.v.count1 - 1 .. 'n')
		end
	end
end

local ope_key ---@type AsteriskKeys

function _G._kjuq_asterisk_operator_search()
	-- When a custom operator is executed, Neovim automatically sets the start position
	-- of the selected range to the '`[' mark, and the end position to the '`]' mark.
	local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, '['))
	local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, ']'))
	local lines = vim.api.nvim_buf_get_text(0, start_row - 1, start_col, end_row - 1, end_col + 1, {})
	local search = table.concat(lines, '\n')
	vim.fn.setreg('/', search)
	vim.fn.histadd('/', search)
	vim.v.hlsearch = true
	vim.v.searchforward = search_forward(ope_key) and 1 or 0
end

---@param key AsteriskKeys
local function operator_search(key)
	local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
	if not vim.tbl_contains({ 'n' }, mode) then
		vim.notify('AsteriskRemix: Unexpected mode detected', vim.log.levels.ERROR)
		return nil
	end
	ope_key = key
	vim.o.operatorfunc = 'v:lua._kjuq_asterisk_operator_search'
	return 'g@'
end

-- This function is modified version of 'neovim/runtime/lua/vim/_defaults.lua/_visual_search()'
-- Copyright Neovim contributors and kjuq. All rights reserved.
-- Licensed under the terms of the Apache 2.0 license. (https://github.com/neovim/neovim/blob/master/LICENSE.txt)
---@param key AsteriskKeys
---@return string
local function visual_search(key)
	assert(key == '*' or key == '#' or key == 'g*' or key == 'g#')
	local pos = vim.fn.getpos('.')
	local vpos = vim.fn.getpos('v')
	local mode = vim.fn.mode()
	local chunks = vim.fn.getregion(pos, vpos, { type = mode })
	local esc_chunks = vim.iter(chunks)
		:map(function(v)
			return vim.fn.escape(v, [[\]])
		end)
		:totable()
	local esc_pat = table.concat(esc_chunks, [[\n]])
	if #esc_pat == 0 then
		vim.api.nvim_echo({ { 'E348: No string under cursor' } }, true, { err = true })
		return '<Esc>'
	end
	local search = [[\V]] .. esc_pat

	vim.fn.setreg('/', search)
	vim.fn.histadd('/', search)
	vim.v.searchforward = search_forward(key) and 1 or 0

	if vim.v.count1 == 1 then
		vim.v.hlsearch = true
		return '<Esc>'
	else
		if vim.v.count1 ~= 1 then
			-- NOTE: Use `silent` to suppress E384 and E385
			vim.cmd([[:silent! :normal! ]] .. vim.v.count1 - 1 .. 'n')
		end

		-- The count has to be adjusted when searching backwards and the cursor
		-- isn't positioned at the beginning of the selection
		local count = vim.v.count1 - 1
		if vim.v.count1 == 0 then
			local _, line, col, _ = unpack(pos)
			local _, vline, vcol, _ = unpack(vpos)
			if
				line > vline
				or mode == 'v' and line == vline and col > vcol
				or mode == 'V' and col ~= 1
				or mode == '\22' and col > vcol
			then
				count = count + 1
			end
		end
		return '<Esc>' .. count .. 'n'
	end
end

local function setup()
	-- stylua: ignore start
	vim.keymap.set('n', '*', function() normal_search('*') end)
	vim.keymap.set('n', '#', function() normal_search('#') end)
	vim.keymap.set('n', 'g*', function() normal_search('g*') end)
	vim.keymap.set('n', 'g#', function() normal_search('g#') end)
	vim.keymap.set('x', '*', function() return visual_search('*') end, { expr = true })
	vim.keymap.set('x', '#', function() return visual_search('#') end, { expr = true })
	vim.keymap.set('n', '<Space>*', function() return operator_search('*') end, { expr = true })
	vim.keymap.set('n', '<Space>#', function() return operator_search('#') end, { expr = true })
	-- stylua: ignore end
end

setup()
