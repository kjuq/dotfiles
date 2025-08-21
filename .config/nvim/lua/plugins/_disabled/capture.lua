---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/tyru/capture.vim' }
spec.cmd = 'Capture'

spec.config = function()
	vim.g.capture_override_buffer = 'replace'
end

return spec
