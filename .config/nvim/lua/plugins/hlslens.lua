local map = require('kjuq.utils.lazy').generate_map('', 'Hlslens: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/kevinhwang91/nvim-hlslens' }
spec.event = { 'CmdlineEnter' }

-- TODO: Add '*' '#' 'g*' 'g#' mappings
spec.keys = {
	map('n', 'n', function()
		require('hlslens').start()
		return 'n'
	end, 'Next matched word', { expr = true }),
	map('N', 'n', function()
		require('hlslens').start()
		return 'N'
	end, 'Previous matched word', { expr = true }),
}

spec.opts = function()
	vim.api.nvim_set_hl(0, 'kjuq_hlsearch_above', { fg = '#81A1C1' })
	vim.api.nvim_set_hl(0, 'kjuq_hlsearch_nearest', { fg = '#BF616A' })
	vim.api.nvim_set_hl(0, 'kjuq_hlsearch_below', { fg = '#81A1C1' })

	return {
		override_lens = function(render, posList, nearest, idx, relIdx)
			local above, below
			if relIdx > 0 then
				below = true
			elseif relIdx < 0 then
				above = true
			end

			local cnt = #posList
			local text = ('[%d/%d]'):format(idx, cnt)

			local space = ' '
			local chunks
			if nearest then
				chunks = { { space }, { text, 'kjuq_hlsearch_nearest' } }
			elseif above then
				chunks = { { space }, { text, 'kjuq_hlsearch_above' } }
			elseif below then
				chunks = { { space }, { text, 'kjuq_hlsearch_below' } }
			end

			local lnum, col = unpack(posList[idx])
			render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
		end,
	}
end

return spec
