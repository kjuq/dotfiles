-- TODO: Dot repeat of Visual mode is not implemented yet

local M = {}

---@class kjuq.JpSpacing.opts
local opts = {
	cmd = 'KjuqJpSpacing',
}

---@param start integer
---@param stop integer
local function substitute(start, stop)
	-- 可読性が最悪だ \(^o^)/
	local reg_bak = vim.fn.getreg('/')
	-- local latin = [=[\[0-9A-Za-z\-=`\/,.;\_+~?|!@#$%%^&*]]=]
	local alphanum = [=[0-9A-Za-z]=]
	local symbol = [=[-=`/\,.;_+~?|!@#$%%^&*]=]
	local latinwd = string.format([=[\[%s]\[%s%s]\*\[%s]]=], alphanum, alphanum, symbol, alphanum)
	local japanese = [=[ぁ-んァ-ヶ一-龠]=]
	local open = [=[\[<([{]\+]=]
	local close = [=[\[>)}\]:]\+]=]
	vim.cmd(string.format([=[ %d,%d s/\V\(%s\)\ze\[%s]/\1 /ge ]=], start, stop, latinwd, japanese))
	vim.cmd(string.format([=[ %d,%d s/\V\[%s]\zs\(%s\)/ \1/ge ]=], start, stop, japanese, latinwd))
	vim.cmd(string.format([=[ %d,%d s/\V\(%s\)\ze\[%s]/\1 /ge ]=], start, stop, close, japanese))
	vim.cmd(string.format([=[ %d,%d s/\V\[%s]\zs\(%s\)/ \1/ge ]=], start, stop, japanese, open))
	vim.cmd(string.format([=[ %d,%d s/\V\S\zs\s\+/ /ge ]=], start, stop))
	vim.fn.setreg('/', reg_bak)
	vim.cmd.nohlsearch()
end

local function init()
	vim.api.nvim_create_user_command(opts.cmd, function(args)
		substitute(args.line1, args.line2)
	end, { range = true })
	---@diagnostic disable-next-line: duplicate-set-field
	function _G.kjuq_jp_spacing()
		local lnum, col = vim.fn.line('.'), vim.fn.col('.') - 1
		vim.cmd(string.format([[ '[,'] %s ]], opts.cmd))
		vim.api.nvim_win_set_cursor(0, { lnum, col })
	end
end

function M.map()
	local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
	if not vim.tbl_contains({ 'n', 'v', 'V' }, mode) then
		vim.notify('kjuq/JP-spacing: Unexpected mode detected', vim.log.levels.ERROR)
		return nil
	end
	if mode == 'n' then
		vim.o.operatorfunc = 'v:lua._G.kjuq_jp_spacing'
		return 'g@'
	elseif mode == 'v' or mode == 'V' then
		vim.o.operatorfunc = nil
		return string.format([[:%s<CR>]], opts.cmd)
	end
end

---@param user_opts kjuq.JpSpacing.opts?
function M.setup(user_opts)
	if user_opts then
		opts = vim.tbl_deep_extend('force', opts, user_opts)
	end
	init()
	vim.keymap.set({ 'n', 'x' }, '<Space>c<Space>', M.map, { expr = true, desc = 'Format EN and JP' })
end

return M
