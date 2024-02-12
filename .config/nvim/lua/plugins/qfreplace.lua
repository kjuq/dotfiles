---@type LazySpec
local spec = { "thinca/vim-qfreplace" }
spec.cmd = "Qfreplace"

spec.keys = {
	{ "<leader>aq", mode = "n", function() vim.cmd("Qfreplace") end, { desc = "Qfreplace: Open" } },
}

return spec
