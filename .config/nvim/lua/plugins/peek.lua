---@type LazySpec
local spec = { 'toppair/peek.nvim' }
spec.build = 'deno task --quiet build:fast'
spec.event = 'VeryLazy'

spec.opts = {}

spec.config = function(_, opts)
	require('peek').setup(opts)
	vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
	vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
end

return spec
