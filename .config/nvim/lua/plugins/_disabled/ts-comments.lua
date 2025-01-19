---@type LazySpec
local spec = { 'folke/ts-comments.nvim' }
spec.event = { 'VeryLazy', 'CursorHold', 'CursorMoved', 'CursorHoldI', 'CursorMovedI' }

spec.opts = {}

return spec
