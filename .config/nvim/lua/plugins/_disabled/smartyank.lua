-- necessary when
-- local client -> local tmux -- ssh --> remote env

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/ibhagwan/smartyank.nvim' }
spec.event = { 'BufReadPost' }

spec.opts = {
	highlight = {
		enabled = false,
	},
	clipboard = {
		enabled = false,
	},
	osc52 = {
		silent = true,
	},
	validate_yank = false,
}

return spec
