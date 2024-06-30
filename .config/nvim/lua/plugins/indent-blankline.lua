---@type LazySpec
local spec = { "lukas-reineke/indent-blankline.nvim" }
spec.main = "ibl"
spec.event = require("utils.lazy").verylazy

spec.config = function()
	-- disable builtin indentline
	vim.opt_local.listchars:remove("leadmultispace")
	vim.api.nvim_clear_autocmds({ group = "init_indent_line" })
	vim.api.nvim_clear_autocmds({ group = "update_indent_line" })

	local highlight = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	}

	local hooks = require("ibl.hooks")
	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#E06C75", nocombine = true })
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#E5C07B", nocombine = true })
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#98C379", nocombine = true })
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#56B6C2", nocombine = true })
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#61AFEF", nocombine = true })
		vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = "#C678DD", nocombine = true })
	end)

	hooks.register(hooks.type.SKIP_LINE, function(_, _, _, line)
		local pattern = "^$" -- empty line
		return line:match(pattern)
	end)

	hooks.register(hooks.type.SKIP_LINE, hooks.builtin.skip_preproc_lines, { bufnr = 0 })

	local opts = {
		indent = {
			highlight = highlight,
			char = "╎", -- "╎", "┆","│", "▏",
			tab_char = "│",
		},
		scope = {
			-- enabled = false,
			show_start = false,
			show_end = false,
		},
		exclude = {
			filetypes = { "oil", "undotree" },
		},
	}

	local ibl = require("ibl")
	ibl.setup(opts)
	ibl.refresh_all()
end

return spec
