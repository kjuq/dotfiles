---@module 'snacks'
---@type LazySpec
local spec = { 'https://github.com/folke/snacks.nvim' }

spec.lazy = false

-- spec.cond = false

local map = require('kjuq.utils.lazy').generate_map('', 'Snacks: ')
spec.keys = {
	map('<Space>ai', 'n', function()
		require('snacks').image.hover()
	end, 'Float image'),
	map('<M-i>', 'n', function()
		require('snacks').setup({ image = { doc = { inline = false } } })
	end, 'Toggle inline'),
}

---@type snacks.Config
spec.opts = {
	image = {
		formats = {
			'png',
			'jpg',
			'jpeg',
			'gif',
			'bmp',
			'webp',
			'tiff',
			'heic',
			'avif',
			'mp4',
			'mov',
			'avi',
			'mkv',
			'webm',
			'pdf',
			'svg',
			'JPG',
		},
		doc = {
			enabled = true,
			inline = false, -- unable to toggle currently (https://github.com/folke/snacks.nvim/issues/1739)
			float = false,
		},
	},
	input = {},
	picker = {
		win = {
			input = {
				keys = {
					['<Esc>'] = { 'close', mode = { 'n', 'i' } },
				},
			},
		},
	},
}

spec.config = function(_, opts)
	require('snacks').setup(opts)
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'image',
		group = vim.api.nvim_create_augroup('kjuq_keymaps_for_snacks_image', {}),
		callback = function()
			vim.keymap.set('n', '<C-Tab>', '<Cmd>bdelete<CR>', { desc = 'Snacks.Image: Close', buffer = true })
		end,
	})
end

return spec
