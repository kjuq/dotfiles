local map = require("utils.lazy").generate_map("", "Kensaku-search: ")

---@type LazySpec
local spec = { "lambdalisue/kensaku-search.vim" }

spec.event = "User UserDenopsActivated"

spec.keys = {
	map("<C-s>", "c", function()
		require("utils.common").feed_plug("kensaku-search-replace")
	end, "Confirm"),
}

spec.config = function()
	vim.api.nvim_exec_autocmds("User", { pattern = "UserDenopsActivated" })
end

spec.dependencies = {
	"vim-denops/denops.vim",
	"lambdalisue/kensaku.vim",
}

return spec
