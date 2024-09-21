vim.loader.enable()

require('core.general')
require('core.options')
require('core.keymaps')
require('core.commands')
require('core.autocmd')
require('core.mouse')

require('core.lazy')

-- should load colorscheme after initialize plugins
require('core.colorscheme')
