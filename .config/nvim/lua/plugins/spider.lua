---@type LazySpec
local spec = { 'chrisgrieser/nvim-spider' }

-- Hiragana (U+3040 - U+309F)
-- Katakana (U+30A0 - U+30FF)
-- Sub-Katakana (カタカナ補助) (U+31F0 - U+31FF)
-- Kanji (U+4E00 - U+9FFF)
-- CJK-compatible Kanji (U+F900 - U+FAFF)
local japanese_regex = '[\u{3040}-\u{30FF}\u{31F0}-\u{31FF}\u{4E00}-\u{9FFF}\u{F900}-\u{FAFF}]+'

local is_japanese_letter = function(str)
	return string.match(str, japanese_regex) ~= nil
end

local map = require('utils.lazy').generate_map('', 'Spider: ')
spec.keys = {
	map('w', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('w')
		end)
	end, 'w'),
	map('b', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('b')
		end)
	end, 'b'),
	map('e', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('e')
		end)
	end, 'e'),
	map('ge', { 'n', 'x', 'o' }, function()
		require('jolyne').motion(function()
			require('spider').motion('ge')
		end)
	end, 'ge'),
}

spec.opts = {
	customPatterns = {
		patterns = { japanese_regex },
		overrideDefault = false,
	},
}

return spec
