---@type LazySpec
local spec = { 'https://github.com/coachshea/vim-textobj-markdown' }
spec.ft = 'markdown'

spec.init = function()
	vim.g.textobj_markdown_no_default_key_mappings = 1
end

spec.config = function()
	local map = function(mode, key, rhs, desc)
		vim.keymap.set(mode, key, rhs, { desc = desc, buffer = true })
	end

	local plug = require('kjuq.utils.common').feed_plug

	local maps = function()
		map({ 'n', 'o', 'x' }, ']#', function()
			plug('textobj-markdown-header-n')
		end, 'Next level 1 header')
		map({ 'n', 'o', 'x' }, '[#', function()
			plug('textobj-markdown-header-p')
		end, 'Previous level 1 header')

		map({ 'n', 'o', 'x' }, '][', function()
			plug('textobj-markdown-Sheader-n')
		end, 'Next level 2 header')
		map({ 'n', 'o', 'x' }, '[]', function()
			plug('textobj-markdown-Sheader-p')
		end, 'Previous level 2 header')

		map({ 'n', 'o', 'x' }, ']}', function()
			plug('textobj-markdown-SSheader-n')
		end, 'Next level 3 header')
		map({ 'n', 'o', 'x' }, '[{', function()
			plug('textobj-markdown-SSheader-p')
		end, 'Previous level 3 header')

		map({ 'n', 'o', 'x' }, ']c', function()
			plug('textobj-markdown-chunk-n')
		end, 'Next start of code fence')
		map({ 'n', 'o', 'x' }, '[c', function()
			plug('textobj-markdown-chunk-p')
		end, 'Previous start of code fence')

		map({ 'n', 'o', 'x' }, ']f', function()
			plug('textobj-markdown-Bchunk-n')
		end, 'Next end of code fence')
		map({ 'n', 'o', 'x' }, '[f', function()
			plug('textobj-markdown-Bchunk-p')
		end, 'Previous end of code fence')

		map({ 'o', 'x' }, 'ic', function()
			plug('textobj-markdown-chunk-i')
		end, 'Inner a code fence')
		map({ 'o', 'x' }, 'ac', function()
			plug('textobj-markdown-chunk-a')
		end, 'A code fence')
	end

	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'markdown',
		callback = maps,
	})
end

spec.dependencies = {
	'kana/vim-textobj-user',
}

return spec
