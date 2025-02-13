-- TODO: Dot repeat of Visual mode is broken

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

local function init()
	vim.api.nvim_create_user_command(opts.cmd, function(args)
		local start = args.line1
		local stop = args.line2
		for pat, sub in pairs(opts.maps) do
			substitute(pat, sub, start, stop)
		end
	end, { range = true })

	function _G.kjuq_rm_multibytes()
		vim.cmd(string.format([[ '[,'] %s ]], opts.cmd))
	end
end

function M.map()
	local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
	if not vim.tbl_contains({ 'n', 'v', 'V' }, mode) then
		vim.notify('Unexpected mode detected', vim.log.levels.ERROR)
		return nil
	end
	if mode == 'n' then
		return [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_rm_multibytes'<CR>g@]]
	elseif mode == 'v' or mode == 'V' then
		return string.format(':%s<CR>', opts.cmd)
	end
end

function M.setup(user_opts)
	if user_opts then
		opts = vim.tbl_deep_extend('force', opts, user_opts)
	end
	init()
end

return M
