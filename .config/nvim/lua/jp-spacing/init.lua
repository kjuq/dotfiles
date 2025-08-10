-- TODO: Dot repeat of Visual mode is not implemented yet

local M = {}

---@class kjuq.rm-multibytes.opts
local opts = {
	cmd = 'KjuqJpSpacing',
}

---@param start integer
---@param stop integer
local function substitute(start, stop)
	local reg_bak = vim.fn.getreg('/')
	-- local latin = [=[\[0-9A-Za-z\-=`\/,.;\_+~?|!@#$%%^&*]]=]
	local alphanum = [=[0-9A-Za-z]=]
	local symbol = [=[-=`/\,.;_+~?|!@#$%%^&*]=]
	local latinwd = string.format([=[\[%s]\[%s%s]\*\[%s]]=], alphanum, alphanum, symbol, alphanum)
	local japanese = [=[ぁ-んァ-ヶ一-龠]=]
	-- local open = [=[<(\{\[]=]
	-- local close = [=[>)\}\]:]=]
	vim.cmd(string.format([=[ %d,%d s/\V\(%s\)\ze\[%s]/\1 /ge ]=], start, stop, latinwd, japanese))
	vim.cmd(string.format([=[ %d,%d s/\V\[%s]\zs\(%s\)/ \1/ge ]=], start, stop, japanese, latinwd))
	vim.fn.setreg('/', reg_bak)
	vim.cmd.nohlsearch()
end

---@type integer, integer
local lnum, col

local function init()
	vim.api.nvim_create_user_command(opts.cmd, function(args)
		substitute(args.line1, args.line2)
	end, { range = true })

	function _G.kjuq_jp_spacing()
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
		local mark_cur = '.'
		lnum, col = vim.fn.line(mark_cur), vim.fn.col(mark_cur) - 1
		vim.o.operatorfunc = 'v:lua._G.kjuq_jp_spacing'
		return 'g@'
	elseif mode == 'v' or mode == 'V' then
		vim.o.operatorfunc = nil
		return string.format([[:%s<CR>]], opts.cmd)
	end
end

function M.setup(user_opts)
	if user_opts then
		opts = vim.tbl_deep_extend('force', opts, user_opts)
	end
	init()
end

return M
