local map = require("utils.lazy").generate_map("<leader>", "Translate: ")

---@type LazySpec
local spec = { "skanehira/denops-translate.vim" }

spec.lazy = false

spec.cmd = "Translate"

spec.keys = {
	map("at", "n", function()
		local cword = vim.fn.expand("<cword>")
		vim.cmd("Translate " .. cword)
	end, "Under the cursor"),
	map("at", "x", function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
		vim.cmd("'<,'>Translate")
	end, "Selected texts"),
}

spec.dependencies = {
	"vim-denops/denops.vim",
}

return spec
