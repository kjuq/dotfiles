-- TODO: Dot repeat of Visual mode is not implemented yet

---@alias kjuq.rm-multibytes.mapping table<string, string>

---@class kjuq.rm-multibytes.opts
---@field cmd string
---@field maps kjuq.rm-multibytes.mapping

local M = {}

---@type kjuq.rm-multibytes.mapping
local maps = {
	-- [ [[、]] ] = [[,]],
	-- [ [[。]] ] = [[.]],
	[ [[　]] ] = [[ ]], -- full-width space
	[ [[，]] ] = [[、]],
	[ [[．]] ] = [[。]],
	[ [[（]] ] = [[(]],
	[ [[）]] ] = [[)]],

	[ [[‘]] ] = [[']],
	[ [[’]] ] = [[']],
	[ [[‚]] ] = [[']],
	[ [[‛]] ] = [[']],
	[ [[“]] ] = [["]],
	[ [[”]] ] = [["]],
	[ [[„]] ] = [["]],
	[ [[‟]] ] = [["]],
	[ [[Ⅰ]] ] = [[I]],
	[ [[Ⅱ]] ] = [[II]],
	[ [[Ⅲ]] ] = [[III]],
	[ [[Ⅳ]] ] = [[IV]],
	[ [[Ⅴ]] ] = [[V]],
	[ [[Ⅵ]] ] = [[VI]],
	[ [[Ⅶ]] ] = [[VII]],
	[ [[Ⅷ]] ] = [[VIII]],
	[ [[Ⅸ]] ] = [[IX]],
	[ [[Ⅹ]] ] = [[X]],
	[ [[Ⅺ]] ] = [[XI]],
	[ [[Ⅻ]] ] = [[XII]],
	[ [[ⅰ]] ] = [[i]],
	[ [[ⅱ]] ] = [[ii]],
	[ [[ⅲ]] ] = [[iii]],
	[ [[ⅳ]] ] = [[iv]],
	[ [[ⅴ]] ] = [[v]],
	[ [[ⅵ]] ] = [[vi]],
	[ [[ⅶ]] ] = [[vii]],
	[ [[ⅷ]] ] = [[viii]],
	[ [[ⅸ]] ] = [[ix]],
	[ [[ⅹ]] ] = [[x]],
	[ [[ⅺ]] ] = [[xi]],
	[ [[ⅻ]] ] = [[xii]],
	[ [[⒈]] ] = [[1.]],
	[ [[⒉]] ] = [[2.]],
	[ [[⒊]] ] = [[3.]],
	[ [[⒋]] ] = [[4.]],
	[ [[⒌]] ] = [[5.]],
	[ [[⒍]] ] = [[6.]],
	[ [[⒎]] ] = [[7.]],
	[ [[⒏]] ] = [[8.]],
	[ [[⒐]] ] = [[9.]],
	[ [[㈠]] ] = [[(一)]],
	[ [[㈡]] ] = [[(二)]],
	[ [[㈢]] ] = [[(三)]],
	[ [[㈣]] ] = [[(四)]],
	[ [[㈤]] ] = [[(五)]],
	[ [[㈥]] ] = [[(六)]],
	[ [[㈦]] ] = [[(七)]],
	[ [[㈧]] ] = [[(八)]],
	[ [[㈨]] ] = [[(九)]],
}

---@class kjuq.rm-multibytes.opts
local opts = {
	maps = maps,
	cmd = 'KjuqRmMB',
}

---@param pat string
---@param sub string
---@param start integer
---@param stop integer
local function substitute(pat, sub, start, stop)
	vim.cmd(string.format([[ %d,%d s/%s/%s/ge ]], start, stop, pat, sub))
end

---@param mappings kjuq.rm-multibytes.mapping
---@param start integer
---@param stop integer
local function substitute_all(mappings, start, stop)
	local reg_bak = vim.fn.getreg('/')
	for pat, sub in pairs(mappings) do
		substitute(pat, sub, start, stop)
	end
	vim.fn.setreg('/', reg_bak)
end

---@type integer, integer
local lnum, col

local function init()
	vim.api.nvim_create_user_command(opts.cmd, function(args)
		substitute_all(opts.maps, args.line1, args.line2)
	end, { range = true })

	function _G.kjuq_rm_multibytes()
		vim.cmd(string.format([[ '[,'] %s ]], opts.cmd))
		vim.api.nvim_win_set_cursor(0, { lnum, col })
	end
end

function M.map()
	local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
	if not vim.tbl_contains({ 'n', 'v', 'V' }, mode) then
		vim.notify('kjuq/Rm-multibytes: Unexpected mode detected', vim.log.levels.ERROR)
		return nil
	end
	if mode == 'n' then
		local mark_cur = '.'
		lnum, col = vim.fn.line(mark_cur), vim.fn.col(mark_cur)
		vim.o.operatorfunc = 'v:lua._G.kjuq_rm_multibytes'
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
