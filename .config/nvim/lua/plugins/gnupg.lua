---@type LazySpec
local spec = { 'https://github.com/jamessan/vim-gnupg' }

spec.lazy = not require('kjuq.utils.common').argv_contains({ '.gpg', '.pgp', '.asc' })

spec.event = 'VeryLazy'

return spec
