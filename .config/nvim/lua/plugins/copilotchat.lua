-- Install `tiktoken_core` with luarocks (optional. This is for displaying prompt token counts)
-- https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#prerequisites

-- authentication is automatically done when Copilot.lua is ready

local map = require('utils.lazy').generate_map('<leader>c', 'CopilotChat: ')

---@type LazySpec
local spec = { 'CopilotC-Nvim/CopilotChat.nvim' }

spec.branch = 'canary'

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

spec.keys = {
	map('o', 'n', function()
		require('CopilotChat').open({ window = { layout = 'replace' } })
	end, 'Open CopilotChat'),
	map('e', { 'n', 'x' }, '<CMD>CopilotChatExplain<CR>', 'Explain code'),
	map('t', { 'n', 'x' }, '<CMD>CopilotChatTests<CR>', 'Generate tests'),
	map('x', { 'n', 'x' }, '<CMD>CopilotChatInPlace<CR>', 'Open In-place chat'),
}

spec.opts = function()
	if pcall(require, 'cmp') then
		require('CopilotChat.integrations.cmp').setup()
	end

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
			end)
		end,
	})

	return {
		show_help = false,
		mappings = {
			complete = {
				detail = 'Use @<C-g><C-n> or /<C-g><C-n> for options.',
				insert = '<C-g><C-n>',
			},
			close = {
				normal = 'gh',
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
			},
			show_diff = {
				normal = 'gd',
			},
			show_system_prompt = {
				normal = 'dp', -- [d]isplay [p]rompt
			},
			show_user_selection = {
				normal = 'gV',
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
