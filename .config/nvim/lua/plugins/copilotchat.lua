-- Install `tiktoken_core` with luarocks (optional. This is for displaying prompt token counts)
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#prerequisites

-- authentication is automatically done when Copilot.lua is ready

---@type LazySpec
local spec = { 'CopilotC-Nvim/CopilotChat.nvim' }

spec.cmd = {
	'CopilotChat',
	'CopilotChatOpen',
	'CopilotChatClose',
	'CopilotChatToggle',
	'CopilotChatStop',
	'CopilotChatReset',
	'CopilotChatSave',
	'CopilotChatLoad',
	'CopilotChatDebugInfo',
	'CopilotChatExplain',
	'CopilotChatReview',
	'CopilotChatFix',
	'CopilotChatOptimize',
	'CopilotChatDocs',
	'CopilotChatTests',
	'CopilotChatFixDiagnostic',
	'CopilotChatCommit',
	'CopilotChatCommitStaged',
}

local map = require('kjuq.utils.lazy').generate_map('<Space>p', 'CopilotChat: ')
spec.keys = {
	map('O', { 'n', 'x' }, '<CMD>CopilotChatOpen<CR>', 'Open'),
	map('e', { 'n', 'x' }, '<CMD>CopilotChatExplain<CR>', 'Explain code'),
	map('T', { 'n', 'x' }, '<CMD>CopilotChatTests<CR>', 'Generate tests'),
	map('i', { 'n', 'x' }, '<CMD>CopilotChatInPlace<CR>', 'Open In-place chat'),
}

spec.opts = function()
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'copilot-chat',
		group = vim.api.nvim_create_augroup('kjuq_copilot_chat', {}),
		callback = function()
			local chat = require('CopilotChat')
			vim.keymap.set('n', 'gs', function()
				local date = os.date('%Y-%m-%d') --[[@ as string]]
				chat.save(date)
			end, { buffer = true })
		end,
	})

	local conceallevel = vim.o.conceallevel
	local cursorline = vim.o.cursorline

	vim.api.nvim_create_autocmd('BufEnter', {
		pattern = 'copilot-*',
		callback = function()
			vim.schedule(function()
				vim.opt_local.conceallevel = conceallevel
				vim.opt_local.cursorline = cursorline
				vim.keymap.set('n', '<C-Tab>', '<Cmd>bnext<CR>', { desc = 'CopilotChat: Close', buffer = true })
			end)
		end,
	})

	return {
		model = 'o3-mini',
		system_prompt = require('kjuq.utils.ai').system_prompt('Japanese'),
		show_help = false,
		chat_autocomplete = true,
		mappings = {
			complete = {
				detail = 'Use @<C-x><C-b> or /<C-x><C-b> for options.',
				insert = '<C-x><C-b>',
			},
			close = {
				normal = '<C-Tab>',
				insert = '<Nop>',
			},
			reset = {
				normal = '<C-l>',
				insert = '<C-l>',
			},
			submit_prompt = {
				normal = '<C-g><C-g>',
				insert = '<C-g><C-g>',
			},
			accept_diff = {
				normal = '<C-g><C-y>',
				insert = '<C-g><C-y>',
			},
			yank_diff = {
				normal = 'gy',
				insert = '<Nop>',
			},
			show_diff = {
				normal = 'gd',
				insert = '<Nop>',
			},
			show_info = {
				normal = 'dp', -- [d]isplay [p]rompt
				insert = '<Nop>',
			},
			show_context = {
				normal = 'gV',
				insert = '<Nop>',
			},
			show_help = {
				normal = 'g?',
				insert = '<Nop>',
			},
		},
	}
end

spec.dependencies = {
	'zbirenbaum/copilot.lua',
}

spec.specs = {
	'nvim-lua/plenary.nvim',
}

return spec
