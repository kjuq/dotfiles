local ft = {}

---@type table<string, kjuq.snp.snippet[]>
local snpft = {
	all = require('kjuq.snippet.ft.all').snippets,
	cpp = require('kjuq.snippet.ft.cpp').snippets,
	lua = require('kjuq.snippet.ft.lua').snippets,
	markdown = require('kjuq.snippet.ft.markdown').snippets,
	python = require('kjuq.snippet.ft.python').snippets,
	bash = require('kjuq.snippet.ft.sh').snippets,
	sh = require('kjuq.snippet.ft.sh').snippets,
	tex = require('kjuq.snippet.ft.tex').snippets,
	typst = require('kjuq.snippet.ft.typst').snippets,
}

local function get_snips_by_ft(filetype)
	local snips = vim.list_slice(snpft.all)

	if filetype and snpft[filetype] then
		vim.list_extend(snips, snpft[filetype])
	end

	return snips
end

function ft.get_buf_snips()
	return get_snips_by_ft(vim.bo.filetype)
end

return ft
