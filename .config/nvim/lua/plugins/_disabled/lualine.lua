local hidden = false

-- https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua

---@type LazySpec
local spec = { 'https://github.com/nvim-lualine/lualine.nvim' }
spec.event = not hidden and 'VeryLazy' or {}

spec.init = function()
	vim.opt.laststatus = hidden and 0 or 3 -- to prevent from scrolling a line up when `setup()`
end

local map = require('kjuq.utils.lazy').generate_map('', 'Lualine: ')
spec.keys = {
	map('<Space>ts', 'n', function()
		if hidden then -- unhide
			local opts = { unhide = true } -- assigning opts is needed to suppress warning
			require('lualine').hide(opts)
		else -- hide
			local opts = {}
			require('lualine').hide(opts)
		end
		hidden = not hidden
	end, 'Toggle'),
}

spec.opts = function()
	vim.opt.laststatus = 0
	-- stylua: ignore
	local colors = {
		bg       = "#202328",
		fg       = "#bbc2cf",
		yellow   = "#ECBE7B",
		cyan     = "#008080",
		darkblue = "#081633",
		green    = "#98be65",
		orange   = "#FF8800",
		violet   = "#a9a1e1",
		magenta  = "#c678dd",
		blue     = "#51afef",
		red      = "#ec5f67",
	}

	-- Config
	local opts = {
		extensions = {
			'aerial',
			'lazy',
			'man',
			'mason',
			'neo-tree',
			'nvim-dap-ui',
			'oil',
			'quickfix',
			'toggleterm',
		},
		options = {
			globalstatus = true,
			refresh = { statusline = 10 },

			-- Disable sections and component separators
			component_separators = '',
			section_separators = '',

			theme = {
				normal = { c = { fg = colors.fg, bg = 'NONE' } }, -- default: bg = colors.bg
				inactive = { c = { fg = colors.fg, bg = 'NONE' } }, -- default: bg = colors.bg
			},
		},
		sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			-- These will be filled later
			lualine_c = {},
			lualine_x = {},
		},
		inactive_sections = {
			-- these are to remove the defaults
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {},
			lualine_x = {},
		},
	}

	local function ins_left(component, left, right)
		left = left or 1
		right = right or 1
		table.insert(
			opts.sections.lualine_c,
			vim.tbl_deep_extend('keep', component, { padding = { left = left, right = right } })
		)
	end

	local function ins_right(component, left, right)
		left = left or 1
		right = right or 1
		table.insert(
			opts.sections.lualine_x,
			vim.tbl_deep_extend('keep', component, { padding = { left = left, right = right } })
		)
	end

	local conds = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
		end,
		hide_in_width = function()
			return vim.api.nvim_get_option_value('columns', {}) > 100
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand('%:p:h')
			local gitdir = vim.fn.finddir('.git', filepath .. ';')
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
		enc_not_utf_8 = function()
			local _, cnt = (vim.bo.fenc or vim.go.enc):gsub('^utf%-8$', '')
			return cnt == 0
		end,
		filefmt_not_unix = function()
			local _, cnt = vim.bo.fileformat:gsub('^unix$', '')
			return cnt == 0
		end,
	}

	local components = {}
	components.filename = {
		'filename',
		path = 3, -- format of path; relative, absolute, and etc. see help for more details
		file_status = true,
		newfile_status = true,
		shorting_target = 0,
		cond = conds.buffer_not_empty,
		color = { fg = colors.magenta, gui = 'bold' },
		symbols = {
			modified = '',
			readonly = '',
			unnamed = '[No Name]',
			newfile = '',
		},
	}
	components.empty = {
		function()
			return ' '
		end,
		cond = conds.hide_in_width,
		padding = 0, -- it is natural to set here
	}
	components.filesize = {
		'filesize',
		fmt = function(str)
			local has_filesize = require('lualine.components.filesize')() ~= ''
			if has_filesize then
				return '(' .. str .. ')'
			else
				return '(NOT SAVED)'
			end
		end,
		max_length = 3,
		cond = conds.hide_in_width,
		color = { fg = colors.magenta, gui = 'bold' },
	}
	components.macro_recording = {
		'macro-recording',
		fmt = function()
			local recording_register = vim.fn.reg_recording()
			if recording_register == '' then
				return ''
			else
				return 'Recording @' .. recording_register
			end
		end,
		color = { fg = colors.orange },
	}
	components.japanese_input = {
		function()
			return '[JAPANESE INPUT]'
		end,
		cond = function()
			return require('kjuq.utils.skk').is_skk_jp_mode_enabled()
		end,
		color = { fg = colors.orange },
	}
	components.searchcount = {
		'searchcount',
		color = { fg = colors.blue, gui = 'bold' },
	}
	components.selectioncount = {
		'selectioncount',
		color = { fg = colors.blue, gui = 'bold' },
	}
	components.diagnostics = {
		'diagnostics',
		sources = { 'nvim_diagnostic' },
		symbols = { error = ' ', warn = ' ', info = ' ' },
		diagnostics_color = {
			color_error = { fg = colors.red },
			color_warn = { fg = colors.yellow },
			color_info = { fg = colors.cyan },
		},
	}
	components.diff = {
		'diff',
		symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.orange },
			removed = { fg = colors.red },
		},
		cond = conds.hide_in_width,
		-- workaround with Gitsigns which works properly even without Gitsigns
		sources = function()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end,
	}
	components.branch = {
		'branch',
		cond = conds.hide_in_width,
		icon = '',
		color = { fg = colors.violet, gui = 'bold' },
	}
	components.bar = {
		function()
			return '--'
		end,
		cond = conds.hide_in_width,
		color = { fg = colors.fg, gui = 'bold' },
	}
	components.lsp = {
		-- Lsp server name .
		function()
			-- local msg = "N/A"
			local msg = ''
			local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				---@diagnostic disable-next-line: undefined-field
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end,
		icon = { '' },
		cond = conds.hide_in_width,
		color = { fg = colors.fg, gui = 'bold' },
	}
	components.encoding = {
		'encoding', -- option component same as &encoding in viml
		fmt = string.upper, -- I'm not sure why it's upper case either ;)
		cond = conds.enc_not_utf_8,
		color = { fg = colors.red, gui = 'bold' },
	}
	components.fileformat = {
		'fileformat', -- line endings
		fmt = string.upper,
		cond = conds.filefmt_not_unix,
		icons_enabled = false,
		color = { fg = colors.red, gui = 'bold' },
	}
	components.filetype = {
		'filetype',
		cond = conds.hide_in_width,
		icon = { align = 'right' },
		color = { fg = colors.fg, gui = 'bold' },
	}

	ins_left(components.filename)
	ins_left(components.filesize, 0, 0)

	ins_right(components.macro_recording)
	ins_right(components.japanese_input)
	ins_right(components.selectioncount)
	ins_right(components.searchcount)
	ins_right(components.diagnostics)
	ins_right(components.diff)
	ins_right(components.branch)
	ins_right(components.bar)
	ins_right(components.lsp)
	ins_right(components.encoding)
	ins_right(components.fileformat)
	ins_right(components.filetype)

	return opts
end

spec.specs = {
	'nvim-tree/nvim-web-devicons',
}

return spec
