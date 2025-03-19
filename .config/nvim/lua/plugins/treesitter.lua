-- Do `:TSInstall all` manually
-- rust and scala take much time to install

---@type LazySpec
local spec = { 'nvim-treesitter/nvim-treesitter' }
spec.event = 'VeryLazy'
spec.build = function()
	require('nvim-treesitter.install').update({ with_sync = false })()
end

spec.opts = {
	ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'regex', 'markdown', 'markdown_inline', 'bash' },
	sync_install = false,
	auto_install = false, -- don't turn this on, it causes error when `tree-sitter` CLI is not installed

	highlight = {
		enable = true,
		disable = function(lang, bufnr)
			local lang_for_disable = {}
			if vim.tbl_contains(lang_for_disable, lang) then
				return true
			end
			local max_line = 50000
			if vim.api.nvim_buf_line_count(bufnr) > max_line then
				return true
			end
		end,
	},

	indent = {
		enable = false,
		disable = { 'python' }, -- buggy in py file where tabs are used for indentation?
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<M-v>',
			node_incremental = '<M-v>',
			-- scope_incremental = "",
			node_decremental = '<M-b>',
		},
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['aC'] = '@class.outer',
				['iC'] = '@class.inner',
				['aT'] = '@conditional.outer', -- [T]rue
				['iT'] = '@conditional.inner',
				['al'] = '@loop.outer',
				['il'] = '@loop.inner',
				['a/'] = '@comment.outer',
				['i/'] = '@comment.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']f'] = '@function.outer',
			},
			goto_next_end = {
				[']F'] = '@function.outer',
			},
			goto_previous_start = {
				['[f'] = '@function.outer',
			},
			goto_previous_end = {
				['[F'] = '@function.outer',
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<M-t>'] = '@parameter.inner',
			},
			swap_previous = {
				['g<M-t>'] = '@parameter.inner',
			},
		},
	},
}

spec.config = function(_, opts)
	require('nvim-treesitter.configs').setup(opts)
end

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter-textobjects',
}

return spec
