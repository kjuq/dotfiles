---@type LazySpec
local spec = { "neovim/nvim-lspconfig" }

spec.config = function()
	require("lspconfig.ui.windows").default_options.border = require("utils.lazy").floatwinborder
end

return spec
