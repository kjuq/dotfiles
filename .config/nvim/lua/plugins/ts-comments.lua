---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/folke/ts-comments.nvim' }
spec.event = { 'VeryLazy', 'CursorHold', 'CursorMoved', 'CursorHoldI', 'CursorMovedI' }

spec.opts = {}

return spec
