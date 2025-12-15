---@module 'dial.types'

local map = require('kjuq.utils.lazy').generate_map('', 'Dial: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/monaqa/dial.nvim' }

spec.keys = {
	-- stylua: ignore start
	map('<C-a>', 'n', function() return require('dial.map').manipulate('increment', 'normal') end, 'Increment'),
	map('<C-x>', 'n', function() return require('dial.map').manipulate('decrement', 'normal') end, 'Decrement'),
	map('g<C-a>', 'n', function() return require('dial.map').manipulate('increment', 'gnormal') end, 'g Increment'),
	map('g<C-x>', 'n', function() return require('dial.map').manipulate('decrement', 'gnormal') end, 'g Decrement'),
	map('<C-a>', 'x', function() return require('dial.map').manipulate('increment', 'visual', 'visual') end, 'Increment'),
	map('<C-x>', 'x', function() return require('dial.map').manipulate('decrement', 'visual', 'visual') end, 'Decrement'),
	map('g<C-a>', 'x', function() return require('dial.map').manipulate('increment', 'gvisual', 'visual') end, 'g Increment'),
	map('g<C-x>', 'x', function() return require('dial.map').manipulate('decrement', 'gvisual', 'visual') end, 'g Decrement'),
	-- stylua: ignore end
}

spec.config = function()
	local augend = require('dial.augend')

	---@param grp Augend[]?
	---@return Augend[]
	local function group(grp)
		if grp == nil then
			grp = {}
		end
		local default = {
			augend.integer.alias.decimal,
			augend.decimal_fraction.new({}),
			augend.integer.alias.hex,
			augend.semver.alias.semver,
			augend.constant.alias.bool,
			augend.constant.alias.alpha,
			augend.constant.alias.Alpha,
			augend.constant.alias.ja_weekday,
			augend.constant.alias.ja_weekday_full,
			augend.misc.alias.markdown_header,
			augend.date.alias['%Y/%m/%d'],
			augend.date.alias['%Y-%m-%d'],
			augend.date.alias['%m/%d'],
			augend.date.alias['%Y年%-m月%-d日'],
			augend.date.alias['%Y年%-m月%-d日(%ja)'],
			augend.date.alias['%H:%M:%S'],
			augend.date.alias['%H:%M'],
			augend.date.new({
				pattern = '%Y 年 %-m 月 %-d 日 (%J)',
				default_kind = 'day',
				only_valid = false,
			}),
			augend.date.new({
				pattern = '%Y-%m-%d (%J)',
				default_kind = 'day',
				only_valid = false,
			}),
			augend.date.new({
				pattern = '%Y/%m/%d (%J)',
				default_kind = 'day',
				only_valid = false,
			}),
			augend.hexcolor.new({ case = 'prefer_upper' }),
			augend.constant.new({ elements = { '||', '&&' } }),
			augend.constant.new({ elements = { 'or', 'and' } }),
		}
		local function tbl_iconcat(tbl1, tbl2)
			for _, v in ipairs(tbl2) do
				tbl1[#tbl1 + 1] = v
			end
			return tbl1
		end
		return tbl_iconcat(default, grp)
	end

	require('dial.config').augends:register_group({
		default = group(),
		visual = group(),
	})
	require('dial.config').augends:on_filetype({
		python = group({
			augend.constant.new({ elements = { 'True', 'False' } }),
		}),
		lua = group({
			augend.paren.new({
				patterns = { { "'", "'" }, { '[[', ']]' }, { '[=[', ']=]' }, { '[==[', ']==]' }, { '[===[', ']===]' } },
				nested = false,
				cyclic = false,
			}),
		}),
	})
end

return spec
