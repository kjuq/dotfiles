---@type { enable: cmp.TriggerEvent[], disable: false }
local autocompletes = {
	enable = { 'InsertEnter', 'TextChanged' },
	disable = false,
}
---@type cmp.TriggerEvent[]|false
local autocomplete = autocompletes.enable

---@type LazySpec
local spec = { 'https://github.com/hrsh7th/nvim-cmp' }

spec.event = { 'InsertEnter', 'CmdlineEnter' }

spec.config = function()
	-- max height of floating cmp window
	vim.opt.pumheight = 8

	local cmp = require('cmp')

	require('kjuq.snippet.cmp').register_cmp_source()

	local copilot_source = cmp.config.sources({ { name = 'copilot' } })
	local normal_sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'emoji' },
		{ name = 'fish' },
		{ name = 'git' },
		{ name = 'kjuq_snippet' },
		{
			name = 'nvim_lsp',
			option = {
				markdown_oxide = {
					keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
				},
			},
		},
	})

	local select_next = function()
		if cmp.visible() then
			cmp.select_next_item()
		else
			cmp.setup({
				sources = normal_sources,
				completion = { autocomplete = autocompletes.enable },
			})
			cmp.complete()
		end
	end

	local select_prev = function()
		if cmp.visible() then
			cmp.select_prev_item()
		else
			cmp.setup({
				sources = copilot_source,
				completion = { autocomplete = autocompletes.enable },
			})
			cmp.complete()
		end
	end

	-- TODO: fallbacking in <C-x><C-k> not working
	local abort = function(fallback)
		if cmp.visible() and vim.fn.pumvisible() ~= 1 then
			cmp.setup({
				completion = { autocomplete = autocompletes.disable },
			})
			cmp.abort()
		else
			fallback()
		end
	end

	local scroll_docs_up = function(fallback)
		if cmp.visible_docs() then
			cmp.scroll_docs(-4)
		else
			fallback()
		end
	end

	local scroll_docs_down = function(fallback)
		if cmp.visible_docs() then
			cmp.scroll_docs(4)
		else
			fallback()
		end
	end

	local toggle_docs = function(fallback)
		if not cmp.visible() then
			fallback()
			return
		end
		if cmp.visible_docs() then
			cmp.close_docs()
			cmp.setup({ view = { docs = { auto_open = false } } })
		else
			cmp.open_docs()
			cmp.setup({ view = { docs = { auto_open = true } } })
		end
	end

	local confirm = function(fallback)
		if cmp.visible() then
			cmp.confirm({ select = true })
		else
			fallback()
		end
	end

	local cmd_select_next = function()
		if cmp.visible() then
			cmp.select_next_item()
		else
			cmp.complete()
			cmp.select_next_item()
		end
	end

	local cmd_select_prev = function()
		if cmp.visible() then
			cmp.select_prev_item()
		else
			cmp.complete()
			cmp.select_prev_item()
		end
	end

	local cmd_history_next = function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		else
			fallback()
		end
	end

	local cmd_history_prev = function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		else
			fallback()
		end
	end

	local utils = require('kjuq.utils.common')
	local scrolldown = utils.floatscrolldown
	local scrollup = utils.floatscrollup

	local mapping_insert = {
		['<C-n>'] = cmp.mapping(select_next, { 'i', 's' }),
		['<C-p>'] = cmp.mapping(select_prev, { 'i', 's' }),
		[scrollup] = cmp.mapping(scroll_docs_up, { 'i', 's' }),
		[scrolldown] = cmp.mapping(scroll_docs_down, { 'i', 's' }),
		['<C-l>'] = cmp.mapping(abort, { 'i', 's' }),
		['<C-e>'] = cmp.mapping(abort, { 'i', 's' }),
		['<C-y>'] = cmp.mapping(confirm, { 'i', 's' }),
		['<C-o>'] = cmp.mapping(toggle_docs, { 'i', 's' }),
	}

	local mapping_cmdline = {
		['<C-n>'] = cmp.mapping(cmd_history_next, { 'c' }),
		['<C-p>'] = cmp.mapping(cmd_history_prev, { 'c' }),
		['<C-i>'] = cmp.mapping(cmd_select_next, { 'c' }),
		['<S-Tab>'] = cmp.mapping(cmd_select_prev, { 'c' }),
		['<C-l>'] = cmp.mapping(abort, { 'c' }),
		['<C-e>'] = cmp.mapping(abort, { 'c' }),
		['<C-y>'] = cmp.mapping(confirm, { 'c' }),
		['<C-o>'] = cmp.mapping(toggle_docs, { 'c' }),
	}

	local opts = {
		completion = {
			autocomplete = autocomplete,
		},
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},
		view = {
			docs = {
				auto_open = true,
			},
		},
		mapping = mapping_insert,
		sources = normal_sources,
		window = {
			completion = cmp.config.window.bordered({ border = vim.o.winborder }),
			documentation = cmp.config.window.bordered({ border = vim.o.winborder }),
		},
		---@diagnostic disable-next-line: missing-fields
		formatting = {
			format = require('lspkind').cmp_format({
				mode = 'text_symbol', -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				symbol_map = { Copilot = '' },
			}),
		},
	}

	cmp.setup(opts)

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = { { name = 'git' } },
	})

	-- restore global autocomplete
	vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
		group = vim.api.nvim_create_augroup('kjuq_cmp_restore_autocomplete', {}),
		callback = function()
			require('cmp').setup({ completion = { autocomplete = autocomplete } })
		end,
	})

	local function enable_skk()
		cmp.setup.buffer({
			-- sources = cmp.config.sources({ { name = 'skkeleton' } }),
			-- completion = { autocomplete = autocompletes.enable },
			sources = {},
		})
	end
	local function disable_skk()
		cmp.setup.buffer({
			sources = normal_sources,
			completion = { autocomplete = autocomplete },
		})
	end

	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'kjuq_enable_jp_mode',
		group = vim.api.nvim_create_augroup('kjuq_skk_enable_jp_mode', {}),
		callback = enable_skk,
	})

	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'kjuq_disable_jp_mode',
		group = vim.api.nvim_create_augroup('kjuq_skk_disable_jp_mode', {}),
		callback = disable_skk,
	})

	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = { 'kjuq_enable_jp_mode', 'skkeleton-enable-pre', 'eskk-enable-pre' },
		group = vim.api.nvim_create_augroup('kjuq_skk_enable_pre', {}),
		callback = function()
			if require('kjuq.utils.skk').is_skk_jp_mode_enabled() then
				return
			end
			enable_skk()
		end,
	})

	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = { 'kjuq_disable_jp_mode', 'skkeleton-disable-pre', 'eskk-disable-pre' },
		group = vim.api.nvim_create_augroup('kjuq_skk_disable_pre', {}),
		callback = function()
			if require('kjuq.utils.skk').is_skk_jp_mode_enabled() then
				return
			end
			disable_skk()
		end,
	})
end

spec.dependencies = {
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'onsails/lspkind.nvim',
	'mtoohey31/cmp-fish',
	{
		'petertriho/cmp-git',
		specs = 'nvim-lua/plenary.nvim',
		opts = {},
	},
	{
		'zbirenbaum/copilot-cmp',
		opts = {},
	},
	{
		'allaman/emoji.nvim',
		specs = 'nvim-lua/plenary.nvim',
		opts = {
			enable_cmp_integration = true,
		},
	},
}

return spec
