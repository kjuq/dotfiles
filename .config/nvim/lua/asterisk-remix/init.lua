local M = {}

---@return boolean
local is_vim_regex_match = function(str, pattern)
	return vim.fn.match(str, pattern) ~= -1
end

---@return boolean
local is_focusing_search_word = function()
	local cword = vim.fn.expand('<cword>')
	local last_pat = vim.fn.getreg('/')
	vim.notify('cword: ' .. cword)
	vim.notify('last_pat: ' .. last_pat)
	return vim.v.hlsearch == 1 and is_vim_regex_match(cword, last_pat)
end

---@param key '*'|'#'|'g*'|'g#'
---@return function
local rhs = function(key)
	local search_forward = key == '*' or key == 'g*'
	local search_backward = key == '#' or key == 'g#'
	return function()
		if is_focusing_search_word() then
			vim.notify('focusing')
			---@type boolean
			local reverse = (vim.v.searchforward == 1 and search_backward)
				or (vim.v.searchforward == 0 and search_forward)
			---@type 'N'|'n'
			local n = reverse and 'N' or 'n'

			-- NOTE: Use `silent` to suppress E384 and E385
			-- E384: Search hit TOP without match for: <search_pattern>
			-- E385: Search hit BOTTOM without match for: <search_pattern>
			vim.cmd([[:silent! :normal ]] .. n)
			return
		end

		local wrapscan_bak = vim.o.wrapscan
		vim.o.wrapscan = true
		vim.cmd.normal({ key .. 'N', bang = true })
		vim.o.wrapscan = wrapscan_bak
	end
end

M.keys = {
	['*'] = rhs('*'),
	['#'] = rhs('#'),
	['g*'] = rhs('g*'),
	['g#'] = rhs('g#'),
}

return M
