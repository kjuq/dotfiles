local skk = require('kjuq.utils.skk')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/vim-skk/skkeleton' }
spec.enabled = vim.fn.executable('deno') ~= 0

spec.event = { 'User DenopsReady', 'InsertEnter' }

spec.keys = skk.mappings('Skkeleton: ', 'skkeleton-enable', 'skkeleton-disable', 'skkeleton-toggle')

spec.config = function()
	-- create $XDG_CONFIG_HOME/skk dir if it doesn't exist
	if vim.fn.isdirectory(skk.skk_dir) == 0 then
		vim.fn.mkdir(skk.skk_dir, 'p')
	end

	local lazy_root = require('lazy.core.config').options.root

	vim.fn['skkeleton#config']({
		eggLikeNewline = false,
		setUndoPoint = true,
		showCandidatesCount = 3,
		selectCandidateKeys = 'arstnei',
		globalDictionaries = {
			vim.fs.joinpath(lazy_root, 'dict', 'SKK-JISYO.L'),
			vim.fs.joinpath(lazy_root, 'dict', 'SKK-JISYO.jinmei'),
		},
		userDictionary = skk.jisyo_user,
		completionRankFile = skk.completion_rank,
	})

	vim.fn['skkeleton#register_kanatable']('rom', {
		['!'] = { '!', '' },
		['?'] = { '?', '' },
		[':'] = { ':', '' },
		['~'] = { '～', '' },
		[' '] = { ' ', '' },
	})

	vim.cmd([[ call add(g:skkeleton#mapped_keys, '<C-p>') ]])
	vim.cmd([[ call add(g:skkeleton#mapped_keys, '<C-n>') ]])

	vim.fn['skkeleton#register_keymap']('henkan', '<C-p>', 'henkanBackward')
	vim.fn['skkeleton#register_keymap']('input', '<C-p>', 'henkanBackward')
	vim.fn['skkeleton#register_keymap']('henkan', '<C-n>', 'henkanForward')
	vim.fn['skkeleton#register_keymap']('input', '<C-n>', 'henkanFirst')
	vim.fn['skkeleton#register_keymap']('henkan', 'x', '')

	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'skkeleton-enable-post',
		group = vim.api.nvim_create_augroup('kjuq_skkeleton_space', {}),
		callback = function()
			vim.keymap.set('i', '<Space>', function()
				vim.fn['skkeleton#handle']('handleKey', { key = { '<c-j>', '<space>' } })
			end, { buffer = true, nowait = true })
			vim.keymap.set('i', '<C-y>', function()
				local phase = vim.g['skkeleton#state'].phase
				if vim.tbl_contains({ 'input:okurinasi', 'input:okuriari', 'henkan' }, phase) then
					vim.fn['skkeleton#handle']('handleKey', { ['function'] = 'kakutei' })
					return ''
				else
					return '<C-y>'
				end
			end, { buffer = true, nowait = true, expr = true })
			vim.keymap.set('i', '<C-w>', function()
				local phase = vim.g['skkeleton#state'].phase
				if vim.tbl_contains({ 'input:okurinasi', 'input:okuriari', 'henkan' }, phase) then
					vim.fn['skkeleton#handle']('handleKey', { ['function'] = 'cancel' })
					return ''
				else
					return '<C-w>'
				end
			end, { buffer = true, nowait = true, expr = true })
			vim.keymap.set('i', '<C-i>', function()
				local phase = vim.g['skkeleton#state'].phase
				if vim.tbl_contains({ 'input:okurinasi', 'input:okuriari', 'henkan' }, phase) then
					return ''
				else
					return '<C-i>'
				end
			end, { buffer = true, nowait = true, expr = true })
		end,
	})

	-- remove "<C-g>" from mapped_keys
	local remove_mapped_keys = function(key)
		local mapped_keys = {}
		for _, v in ipairs(vim.g['skkeleton#mapped_keys']) do
			if v ~= key then
				table.insert(mapped_keys, v)
			end
		end
		vim.g['skkeleton#mapped_keys'] = mapped_keys
	end
	remove_mapped_keys('<C-g>')
	remove_mapped_keys('<C-j>')

	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'skkeleton-enable-post',
		group = vim.api.nvim_create_augroup('kjuq_skkeleton_disables_completion', {}),
		callback = function(ev)
			for _, client in ipairs(vim.lsp.get_clients()) do
				if client:supports_method('textDocument/completion', ev.buf) then
					vim.lsp.completion.enable(false, client.id, ev.buf)
				end
			end
			local ok, cmp = pcall(require, 'cmp')
			if ok then
				cmp.setup({ enabled = false })
			end
		end,
	})
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'skkeleton-disable-post',
		group = vim.api.nvim_create_augroup('kjuq_skkeleton_enables_completion', {}),
		callback = function(ev)
			for _, client in ipairs(vim.lsp.get_clients()) do
				if client:supports_method('textDocument/completion', ev.buf) then
					vim.lsp.completion.enable(true, client.id, ev.buf)
				end
			end
			local ok, cmp = pcall(require, 'cmp')
			if ok then
				cmp.setup({ enabled = true })
			end
		end,
	})
end

spec.specs = {
	'skk-dev/dict',
}

spec.dependencies = {
	'vim-denops/denops.vim',
	{
		'delphinus/skkeleton_indicator.nvim',
		event = 'VeryLazy',
		opts = {
			alwaysShown = false,
			fadeOutMs = 0,
			zindex = 1,
		},
	},
}

return spec
