-- Buggy when switching buffer with opened quickfix window

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/stevearc/stickybuf.nvim' }
spec.lazy = false
spec.event = 'WinEnter'

spec.opts = {}

return spec
