---@type LazySpec
local spec = { "chrishrb/gx.nvim" }
spec.keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } }
spec.cmd = { "Browse" }

spec.init = function()
	vim.g.netrw_nogx = 1 -- disable netrw gx
end

spec.opts = {}

spec.dependencies = { "nvim-lua/plenary.nvim" }

return spec
