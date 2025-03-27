local map = require('kjuq.utils.lazy').generate_map('', 'LspSaga: ')

---@type LazySpec
local spec = { 'nvimdev/lspsaga.nvim' }

spec.event = 'LspAttach'

spec.cmd = 'Lspsaga'

spec.opts = {
	symbol_in_winbar = { enable = false },
	lightbulb = { enable = false },
	scroll_preview = {
		scroll_down = require('kjuq.utils.common').floatscrolldown,
		scroll_up = require('kjuq.utils.common').floatscrollup,
	},
	ui = {
		border = vim.o.winborder,
	},
	finder = {
		max_height = 0.6,
		keys = {
			shuttle = { ']w', '[w' },
			toggle_or_open = { 'o', '<CR>' },
			quit = { 'q', '<ESC>' },
			tabe = '<Nop>',
			tabnew = '<Nop>',
		},
		methods = {
			tyd = vim.lsp.protocol.Methods.textDocument_typeDefinition,
			dec = vim.lsp.protocol.Methods.textDocument_declaration,
		},
	},
	callhierarchy = {
		keys = {
			quit = { 'q', '<Esc>' },
			tabe = '<Nop>',
		},
	},
	code_action = {
		keys = {
			quit = { 'q', '<Esc>' },
		},
	},
	definition = {
		keys = {
			quit = { 'q', '<Esc>' },
		},
	},
	diagnostic = {
		max_height = 0.8,
		keys = {
			quit = { 'q', '<Esc>' },
		},
	},
	rename = {
		in_select = true,
		keys = {
			quit = { 'q', '<Esc>' },
		},
	},
	hover = {
		max_width = require('kjuq.utils.lsp').float_max_width,
		max_height = require('kjuq.utils.lsp').float_max_height,
		open_link = 'gx',
		open_cmd = '!xdg-open',
	},
	outline = {
		win_width = 45,
		auto_preview = false,
		detail = true,
		keys = {
			toggle_or_jump = { 'o', '<CR>' },
			quit = { 'q', '<Esc>' },
		},
	},
}

spec.config = function(_, opts)
	require('lspsaga').setup(opts)
	local onattach = function(ev)
		local bufnr = ev.buf
		local set = function(mode, key, cmd, desc)
			vim.keymap.set(mode, key, '<Cmd>Lspsaga ' .. cmd .. '<CR>', { desc = 'Lspsaga: ' .. desc, buffer = bufnr })
		end
		set('n', 'gD', 'finder def+ref+imp+tyd<CR>', 'Finder')
		set('n', 'gd', 'goto_definition', 'Go to definition')
		set('n', 'K', 'hover_doc', 'Hover')
		set('n', 'gri', 'finder imp', 'Find implementation')
		set('n', 'grt', 'finder tyd', 'Find type definition')
		set('n', 'grd', 'finder dec', 'Find declaration')
		set('n', 'grr', 'finder ref', 'Find references')
		set('n', 'grc', 'imcoming_calls', 'Imcoming calls')
		set('n', 'grg', 'outgoing_calls', 'Outgoing calls')
	end
	vim.api.nvim_create_autocmd({ 'LspAttach' }, {
		group = vim.api.nvim_create_augroup('kjuq_lspsaga', {}),
		callback = onattach,
	})
end

spec.specs = {
	'nvim-tree/nvim-web-devicons',
	'nvim-treesitter/nvim-treesitter',
}

return spec
