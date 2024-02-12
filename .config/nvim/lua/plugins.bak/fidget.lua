---@type LazySpec
local spec = { "j-hui/fidget.nvim" }
spec.event = "LspAttach"

spec.opts = {
	notification = {
		filter = vim.log.levels.TRACE,
		override_vim_notify = true,
	}
}

return spec
