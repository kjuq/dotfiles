-- https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua

---@type LazySpec
local spec = { "nvim-lualine/lualine.nvim" }
spec.event = require("utils.lazy").verylazy

spec.init = function()
	vim.opt.laststatus = 0
end

spec.opts = function()
	-- Color table for highlights
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
			"aerial",
			"lazy",
			"man",
			"mason",
			"neo-tree",
			"nvim-dap-ui",
			"oil",
			"quickfix",
			"toggleterm",
		},
		options = {
			globalstatus = true,
			refresh = { statusline = 10 },

			-- Disable sections and component separators
			component_separators = "",
			section_separators = "",

			theme = {
				normal = { c = { fg = colors.fg, bg = "NONE" } }, -- default: bg = colors.bg
				inactive = { c = { fg = colors.fg, bg = "NONE" } }, -- default: bg = colors.bg
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

	-- Inserts a component in lualine_c at left section
	local function ins_left(component)
		table.insert(opts.sections.lualine_c, component)
	end

	-- Inserts a component in lualine_x at right section
	local function ins_right(component)
		table.insert(opts.sections.lualine_x, component)
	end

	local conds = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		hide_in_width = function()
			return vim.api.nvim_get_option_value("columns", {}) > 100
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
		enc_not_utf_8 = function()
			local _, cnt = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
			return cnt == 0
		end,
		filefmt_not_unix = function()
			local _, cnt = vim.bo.fileformat:gsub("^unix$", "")
			return cnt == 0
		end,
	}

	ins_left({
		function()
			return " "
		end,
		cond = conds.hide_in_width,
		padding = 0,
	})

	ins_left({
		-- mode component
		function()
			return "" -- "", "", "", "󰅬"
		end,
		cond = conds.hide_in_width,
		color = function()
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}
			return { fg = mode_color[vim.fn.mode()] }
		end,
	})

	local file = {
		color = { fg = colors.magenta, gui = "bold" },
	}

	ins_left({
		"filename",
		path = 0, -- format of path; relative, absolute, and etc. see help for more details
		file_status = true,
		newfile_status = true,
		cond = conds.buffer_not_empty,
		color = file.color,
		symbols = {
			modified = "", -- Text to show when the file is modified.
			readonly = "", -- Text to show when the file is non-modifiable or readonly.
			unnamed = "[No Name]", -- Text to show for unnamed buffers.
			newfile = "", -- Text to show for newly created file before first write
		},
	})

	local fs = require("lualine.components.filesize")

	ins_left({
		function()
			return "("
		end,
		cond = function()
			return fs() ~= "" and conds.hide_in_width()
		end,
		color = file.color,
		padding = 0,
	})

	ins_left({
		"filesize",
		cond = conds.hide_in_width,
		color = { fg = colors.magenta, gui = "bold" },
		padding = 0, -- default is { left = 1, right = 1 }
	})

	ins_left({
		function()
			return ")"
		end,
		cond = function()
			return fs() ~= "" and conds.hide_in_width()
		end,
		color = file.color,
		padding = { left = 0, right = 1 },
	})

	ins_left({
		"branch",
		icon = "",
		color = { fg = colors.violet, gui = "bold" },
	})

	ins_left({
		"diff",
		-- Is it me or the symbol for modified us really weird
		symbols = { added = " ", modified = "󰝤 ", removed = " " },
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
	})

	ins_left({
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = { error = " ", warn = " ", info = " " },
		diagnostics_color = {
			color_error = { fg = colors.red },
			color_warn = { fg = colors.yellow },
			color_info = { fg = colors.cyan },
		},
	})

	ins_right({
		"macro-recording",
		fmt = function()
			local recording_register = vim.fn.reg_recording()
			if recording_register == "" then
				return ""
			else
				return "Recording @" .. recording_register
			end
		end,
		color = { fg = colors.orange },
	})

	ins_right({
		-- show typed (partial) command (:h showcmd)
		function()
			return "%S"
		end,
		color = { fg = colors.yellow, gui = "bold" },
	})

	ins_right({
		"searchcount",
		color = { fg = colors.blue, gui = "bold" },
		padding = { left = 1, right = 0 },
	})

	ins_right({
		"selectioncount",
		color = { fg = colors.blue, gui = "bold" },
		padding = { left = 1, right = 0 },
	})

	ins_right({
		"location",
		color = { fg = colors.fg, gui = "bold" },
		padding = { left = 2, right = 0 },
	})

	ins_right({
		"progress",
		color = { fg = colors.fg, gui = "bold" },
	})

	ins_right({
		function()
			return "--"
		end,
		cond = conds.hide_in_width,
		color = { fg = colors.fg, gui = "bold" },
	})

	ins_right({
		-- Lsp server name .
		function()
			-- local msg = "N/A"
			local msg = ""
			local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
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
		icon = { "" },
		color = { fg = colors.fg, gui = "bold" },
	})

	ins_right({
		"encoding", -- option component same as &encoding in viml
		fmt = string.upper, -- I'm not sure why it's upper case either ;)
		cond = conds.enc_not_utf_8,
		color = { fg = colors.red, gui = "bold" },
	})

	ins_right({
		"fileformat",
		fmt = string.upper,
		cond = conds.filefmt_not_unix,
		icons_enabled = false,
		color = { fg = colors.red, gui = "bold" },
	})

	ins_right({
		"filetype",
		icon = { align = "right" },
		color = { fg = colors.fg, gui = "bold" },
	})

	ins_right({
		function()
			return " "
		end,
		cond = conds.hide_in_width,
		padding = 0,
	})

	return opts
end

spec.dependencies = {
	"nvim-tree/nvim-web-devicons",
}

return spec
