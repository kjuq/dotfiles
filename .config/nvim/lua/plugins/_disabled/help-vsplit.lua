---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/anuvyklack/help-vsplit.nvim' }

spec.cond = false

spec.keys = { { 'h', mode = 'c' } }
spec.ft = { 'fzf', 'TelescopePrompt' }

spec.opts = { side = 'right' }

return spec
