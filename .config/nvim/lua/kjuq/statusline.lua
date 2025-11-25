local M = {}

function _G.kjuq_stl_macrorec()
	if vim.fn.reg_recording() == '' then
		return ''
	end
	return vim.fn.reg_recording() .. ' '
end

function _G.kjuq_stl_searchcount()
	if vim.v.hlsearch == 0 then
		return ''
	end
	local maxcount = 999
	local timeout = 500
	local result = vim.fn.searchcount({ maxcount = maxcount, timeout = timeout })
	if not (result.total or result.maxcount) then
		return
	end
	local denominator = math.min(result.total, result.maxcount)
	return string.format('%d/%d ', result.current, denominator)
end

function _G.kjuq_stl_encoding()
	local enc = vim.o.fileencoding
	if enc == 'utf-8' then
		return ''
	end
	return string.upper(enc) .. ' '
end

function _G.kjuq_stl_fileformat()
	local ffmt = vim.o.fileformat
	if ffmt == 'unix' then
		return ''
	end
	return string.upper(ffmt) .. ' '
end

function _G.kjuq_stl_diagnostic_error()
	if vim.diagnostic.count == nil then -- neovim >= 0.10.0 is required
		return ''
	end
	local count = vim.diagnostic.count(0)
	local err = count[vim.diagnostic.severity.ERROR] or 0
	if err == 0 then
		return ''
	end

	return 'E:' .. err .. ' '
end

function _G.kjuq_stl_diagnostic_warn()
	if vim.diagnostic.count == nil then -- neovim >= 0.10.0 is required
		return ''
	end
	local count = vim.diagnostic.count(0)
	local warn = count[vim.diagnostic.severity.WARN] or 0
	if warn == 0 then
		return ''
	end

	return 'W:' .. warn .. ' '
end

function _G.kjuq_stl_diagnostic_info()
	if vim.diagnostic.count == nil then -- neovim >= 0.10.0 is required
		return ''
	end
	local count = vim.diagnostic.count(0)
	local info = count[vim.diagnostic.severity.INFO] or 0
	if info == 0 then
		return ''
	end

	return 'I:' .. info .. ' '
end

function _G.kjuq_stl_diagnostic_hint()
	if vim.diagnostic.count == nil then -- neovim >= 0.10.0 is required
		return ''
	end
	local count = vim.diagnostic.count(0)
	local hint = count[vim.diagnostic.severity.HINT] or 0
	if hint == 0 then
		return ''
	end

	return 'H:' .. hint .. ' '
end

---@param highlight string
---@param item string
local function color(highlight, item)
	return '%#' .. highlight .. '#' .. item .. '%#StatusLine#'
end

local components = {
	fullpath = color('Comment', '%F'),
	readonly = color('StatusLine', ' %R'),
	modified = color('StatusLine', ' %m'),
	separator = '%=',
	filetype = color('StatusLine', '%{&filetype}'),
	macro_rec = color('Number', '%{v:lua._G.kjuq_stl_macrorec()}'),
	searchcount = color('Label', '%{v:lua._G.kjuq_stl_searchcount()}'),
	encoding = color('Error', '%{v:lua._G.kjuq_stl_encoding()}'),
	fileformat = color('Error', '%{v:lua._G.kjuq_stl_fileformat()}'),
	diagnostic_error = color('DiagnosticError', '%{v:lua._G.kjuq_stl_diagnostic_error()}'),
	diagnostic_warn = color('DiagnosticWarn', '%{v:lua._G.kjuq_stl_diagnostic_warn()}'),
	diagnostic_info = color('DiagnosticInfo', '%{v:lua._G.kjuq_stl_diagnostic_info()}'),
	diagnostic_hint = color('DiagnosticHint', '%{v:lua._G.kjuq_stl_diagnostic_hint()}'),
	blank = ' ',

	-- TODO: add diff and branch?
}

M.statusline = table.concat({
	components.blank,

	components.fullpath,
	components.modified,
	components.readonly,

	components.separator, ----------------

	components.macro_rec,
	components.searchcount,
	components.diagnostic_error,
	components.diagnostic_warn,
	components.diagnostic_info,
	components.diagnostic_hint,
	components.encoding,
	components.fileformat,
	components.filetype,

	components.blank,
}, '')

return M
