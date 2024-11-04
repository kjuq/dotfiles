---@alias AsteriskKeys '*'|'#'|'g*'|'g#'

local M = {}

---@return boolean
local is_vim_regex_match = function(str, pattern)
	return vim.fn.match(str, pattern) ~= -1
end

---@return boolean
local is_focusing_search_word = function()
	local cword = vim.fn.expand('<cword>')
	local last_pat = vim.fn.getreg('/')
	return vim.v.hlsearch == 1 and is_vim_regex_match(cword, last_pat)
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
local move_candidates = function(key)
	if vim.v.searchforward == 1 and search_backward(key) then
		vim.v.searchforward = 0
	elseif vim.v.searchforward == 0 and search_forward(key) then
		vim.v.searchforward = 1
	end

	-- NOTE: Use `silent` to suppress E384 and E385
	-- E384: Search hit TOP without match for: <search_pattern>
	-- E385: Search hit BOTTOM without match for: <search_pattern>
	vim.cmd([[:silent! :normal! ]] .. vim.v.count1 .. 'n')
end

---@param key AsteriskKeys
local search_word_under_cursor = function(key)
	-- HACK: stop using this tricky method
	-- HACK: (I think it's going to be hard to deal with `wrapscan` option)
	-- screen moves when start searching on the word at beginning or ending :(
	-- ideas:
	-- `setreg('/', vim.fn.expand('<cword>'))`
	-- `set hlsearch`
	local wrapscan_bak = vim.o.wrapscan
	vim.o.wrapscan = true
	vim.cmd.normal({ vim.v.count1 .. key .. 'N', bang = true })
	vim.o.wrapscan = wrapscan_bak
end

---@param key AsteriskKeys
---@return function
local rhs = function(key)
	return function()
		if vim.fn.expand('<cword>') == '' then
			return
		end

		if is_focusing_search_word() then
			move_candidates(key)
		else
			search_word_under_cursor(key)
		end
	end
end

M.keys = {
	['*'] = rhs('*'),
	['#'] = rhs('#'),
	['g*'] = rhs('g*'),
	['g#'] = rhs('g#'),
}

return M
