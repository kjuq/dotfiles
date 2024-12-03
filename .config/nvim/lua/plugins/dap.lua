local map = require('utils.lazy').generate_map('<Space>D', 'Dap: ')

---@type LazySpec
local spec = { 'mfussenegger/nvim-dap' }

spec.keys = {
	map('B', 'n', function()
		require('dap').set_breakpoint(vim.fn.input('BP condition: '))
	end, 'Breakpoint condition'),
	map('b', 'n', function()
		require('dap').toggle_breakpoint()
	end, 'Breakpoint'),
	map('c', 'n', function()
		require('dap').continue()
	end, 'Continue'),
	map('a', 'n', function()
		---@diagnostic disable-next-line: undefined-global (get_args)
		require('dap').continue({ before = get_args })
	end, 'Run with args'),
	map('C', 'n', function()
		require('dap').run_to_cursor()
	end, 'Run to cursor'),
	map('g', 'n', function()
		require('dap').goto_()
	end, 'Go to line (no execute)'),
	map('i', 'n', function()
		require('dap').step_into()
	end, 'Step into'),
	map('j', 'n', function()
		require('dap').down()
	end, 'Down'),
	map('k', 'n', function()
		require('dap').up()
	end, 'Up'),
	map('l', 'n', function()
		require('dap').run_last()
	end, 'Run last'),
	map('o', 'n', function()
		require('dap').step_out()
	end, 'Step out'),
	map('O', 'n', function()
		require('dap').step_over()
	end, 'Step over'),
	map('p', 'n', function()
		require('dap').pause()
	end, 'Pause'),
	map('r', 'n', function()
		require('dap').repl.toggle()
	end, 'Toggle REPL'),
	map('s', 'n', function()
		require('dap').session()
	end, 'Session'),
	map('t', 'n', function()
		require('dap').terminate()
	end, 'Terminate'),
	map('w', 'n', function()
		require('dap.ui.widgets').hover()
	end, 'Widgets'),
}

spec.cmd = {
	'DapContinue',
	'DapInstall',
	'DapLoadLaunchJSON',
	'DapRestartFrame',
	'DapSetLogLevel',
	'DapShowLog',
	'DapStepInto',
	'DapStepOut',
	'DapStepOver',
	'DapTerminate',
	'DapToggleBreakpoint',
	'DapToggleRepl',
	'DapUninstall',
	'DapVirtualTextDisable',
	'DapVirtualTextEnable',
	'DapVirtualTextForceRefresh',
	'DapVirtualTextToggle',
}

spec.opts = {
	handlers = { -- https://zenn.dev/pluck/articles/17f0b3770146ad
		function(config)
			require('mason-nvim-dap').default_setup(config)
		end,
	},
}

spec.config = function(_, opts)
	require('mason-nvim-dap').setup(opts)
	vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#CA4F4F' })
	vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' }) -- 󰧞 
end

spec.dependencies = {
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'jay-babu/mason-nvim-dap.nvim',
	{
		'rcarriga/nvim-dap-ui',
		keys = {
			map('d', 'n', function()
				require('dapui').toggle()
			end, 'Toggle UI'),
		},
		config = function()
			local dap, dapui = require('dap'), require('dapui')
			dap.listeners.after.event_initialized['dapui_config'] = dapui.open
			dap.listeners.before.event_terminated['dapui_config'] = dapui.close
			dap.listeners.before.event_exited['dapui_config'] = dapui.close
			require('dapui').setup()
		end,
		dependencies = {
			'nvim-neotest/nvim-nio',
		},
	},
	{
		'theHamsta/nvim-dap-virtual-text',
		opts = {
			display_callback = function(variable, _, _, _, options)
				if options.virt_text_pos == 'inline' then
					return ' = ' .. variable.value
				else
					return '  ' .. variable.name .. ' = ' .. variable.value
				end
			end,
			virt_text_pos = 'eol',
		},
	},
}

return spec
