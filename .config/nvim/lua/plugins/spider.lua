---@type LazySpec
local spec = { 'https://github.com/chrisgrieser/nvim-spider' }

-- Hiragana (U+3040 - U+309F)
-- Katakana (U+30A0 - U+30FF)
-- Sub-Katakana (カタカナ補助) (U+31F0 - U+31FF)
-- Kanji (U+4E00 - U+9FFF)
-- CJK-compatible Kanji (U+F900 - U+FAFF)
local japanese_regex = '[\u{3040}-\u{30FF}\u{31F0}-\u{31FF}\u{4E00}-\u{9FFF}\u{F900}-\u{FAFF}]'

---@return string
local get_char_under_cursor = function()
	local pos = vim.api.nvim_win_get_cursor(0)
	local col = pos[2]
	local line = vim.api.nvim_get_current_line()
	local char_under_cursor = line:sub(col + 1, col + 1)
	return char_under_cursor
end

local is_japanese_letter = function(str)
	return string.match(str, japanese_regex) ~= nil
end

local map = require('kjuq.utils.lazy').generate_map('', 'Spider: ')
---@param key 'w'|'b'|'e'|'ge'
local map_spider = function(key)
	local rhs = function()
		if is_japanese_letter(get_char_under_cursor()) then
			vim.cmd.normal({ key, bang = true })
		else
			require('spider').motion(key)
		end
	end
	return map(key, { 'n', 'x' }, rhs, key)
end
spec.keys = {
	map_spider('w'),
	map_spider('b'),
	map_spider('e'),
	map_spider('ge'),
}

spec.opts = {
	customPatterns = {
		patterns = { japanese_regex },
		overrideDefault = false,
	},
}

return spec
