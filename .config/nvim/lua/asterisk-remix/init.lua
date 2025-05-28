---@alias AsteriskKeys '*'|'#'|'g*'|'g#'

local M = {}

---@return boolean
local is_focusing_search_word = function()
	local cword = vim.fn.expand('<cword>')
	local last_pat = vim.fn.getreg('/')
	return vim.v.hlsearch == 1 and vim.fn.match(cword, last_pat) ~= -1
end

---@param key AsteriskKeys
local search_forward = function(key)
	return key == '*' or key == 'g*'
end

---@param key AsteriskKeys
local search_backward = function(key)
	return key == '#' or key == 'g#'
end

---@param key AsteriskKeys
function M.normal_search(key)
	if vim.fn.expand('<cword>') == '' then
		return
	end
	if is_focusing_search_word() then
		if vim.v.searchforward == 1 and search_backward(key) then
			vim.v.searchforward = 0
		elseif vim.v.searchforward == 0 and search_forward(key) then
			vim.v.searchforward = 1
		end

		vim.cmd([[:silent! :normal! ]] .. vim.v.count1 .. 'n')
	else
		local search = [[\V]] .. vim.fn.expand('<cword>')
		vim.fn.setreg('/', search)
		vim.fn.histadd('/', search)
		vim.v.searchforward = search_forward(key) and 1 or 0
		vim.v.hlsearch = true
		if vim.v.count1 ~= 1 then
			vim.cmd([[:silent! :normal! ]] .. vim.v.count1 - 1 .. 'n')
		end
	end
end

-- This function is modified version of 'neovim/runtime/lua/vim/_defaults.lua/_visual_search()'
-- Copyright Neovim contributors and kjuq. All rights reserved.
-- Licensed under the terms of the Apache 2.0 license. (https://github.com/neovim/neovim/blob/master/LICENSE.txt)
---@param forward 0|1
---@return string
function M.visual_search(forward)
	assert(forward == 0 or forward == 1)
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
	vim.v.searchforward = forward

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
		if forward == 0 then
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

return M
