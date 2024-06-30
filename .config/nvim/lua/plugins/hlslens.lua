local map = require("utils.lazy").generate_map("", "Hlslens: ")

local asterisk_installed = vim.fn.isdirectory(vim.fn.stdpath("data") .. "/lazy/vim-asterisk") == 1

local rhs = function(key)
	local asterisk = {
		n = "n",
		N = "N",
		["*"] = "<Plug>(asterisk-z*)<CR>",
		["g*"] = "<Plug>(asterisk-gz*)<CR>",
		["#"] = "<Plug>(asterisk-z#)<CR>",
		["g#"] = "<Plug>(asterisk-gz#)<CR>",
	}
	return function()
		require("hlslens").start()
		if asterisk_installed then
			return asterisk[key]
		else
			return vim.v.count1 .. key
		end
	end
end

---@type LazySpec
local spec = { "kevinhwang91/nvim-hlslens" }
spec.event = { "CmdlineEnter" }

spec.keys = {
	map("n", "n", rhs("n"), "Next matched word", { expr = true }),
	map("N", "n", rhs("N"), "Previous matched word", { expr = true }),
	map("*", "n", rhs("*"), "Search forward current word", { expr = true }),
	map("#", "n", rhs("#"), "Search backward current word", { expr = true }),
	map("g*", "n", rhs("g*"), '* without "\\<" and "\\>"', { expr = true }),
	map("g#", "n", rhs("g*"), '# without "\\<" and "\\>"', { expr = true }),
}

spec.opts = {
	override_lens = function(render, posList, nearest, idx, relIdx)
		local above, below
		if relIdx > 0 then
			below = true
		elseif relIdx < 0 then
			above = true
		end

		local cnt = #posList
		local text = ("[%d/%d]"):format(idx, cnt)

		local space = " "
		local chunks
		if nearest then
			chunks = { { space }, { text, "UserHlSearchNearest" } }
		elseif above then
			chunks = { { space }, { text, "UserHlSearchAbove" } }
		elseif below then
			chunks = { { space }, { text, "UserHlSearchBelow" } }
		end

		local lnum, col = unpack(posList[idx])
		render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
	end,
}

spec.config = function(_, opts)
	vim.api.nvim_set_hl(0, "UserHlSearchAbove", { fg = "#81A1C1" })
	vim.api.nvim_set_hl(0, "UserHlSearchNearest", { fg = "#BF616A" })
	vim.api.nvim_set_hl(0, "UserHlSearchBelow", { fg = "#81A1C1" })

	require("hlslens").setup(opts)
end

return spec
