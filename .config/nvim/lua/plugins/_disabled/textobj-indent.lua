local map = require('kjuq.utils.lazy').generate_map('', 'Textobj-indent: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/kana/vim-textobj-indent' }

spec.keys = {
	map('ai', { 'x', 'o' }, '<Plug>(textobj-indent-a)', 'Around', { silent = true }),
	map('ii', { 'x', 'o' }, '<Plug>(textobj-indent-i)', 'Inner', { silent = true }),
}

spec.init = function()
	vim.g.textobj_indent_no_default_key_mappings = true
end

spec.dependencies = {
	'kana/vim-textobj-user',
}

return spec

-- These keymaps are defined by default
-- ai: <Plug>(textobj-indent-a)
-- ii: <Plug>(textobj-indent-i)
-- aI: <Plug>(textobj-indent-same-a)
-- iI: <Plug>(textobj-indent-same-i)
