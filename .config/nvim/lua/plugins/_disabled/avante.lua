---@type LazySpec
local spec = { 'https://github.com/yetone/avante.nvim' }

-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
spec.build = vim.fn.has('win32') ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
	or 'make'
spec.version = false -- Never set this value to "*"! Never!
spec.cond = false

spec.event = 'VeryLazy'

spec.cmd = {
	'AvanteAsk',
	'AvanteBuild',
	'AvanteChat',
	'AvanteChatNew',
	'AvanteHistory',
	'AvanteClear',
	'AvanteEdit',
	'AvanteFocus',
	'AvanteRefresh',
	'AvanteStop',
	'AvanteSwitchProvider',
	'AvanteShowRepoMap',
	'AvanteToggle',
	'AvanteModels',
	'AvanteSwitchSelectorProvider',
}

---@module 'avante'
---@type avante.Config
spec.opts = {
	provider = 'gemini',
	auto_suggestions_provider = 'gemini',
	providers = {
		gemini = {
			model = 'gemini-2.5-pro',
		},
	},
	behaviour = {
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
		minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
		enable_token_counting = true, -- Whether to enable token counting. Default to true.
		auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
		-- Examples:
		-- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
		-- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only
	},
}

spec.config = function(_, opts)
	local gemini_api_key = ''
	local job = vim.system({ 'pass', 'google.com/gemini_api_key' }, { text = true }):wait()
	if job.code == 0 and job.stdout then
		gemini_api_key = job.stdout:gsub('\n$', '') --[[@as string]]
	else
		vim.notify(('code: %d, stderr: %s'):format(job.code, job.stderr), vim.log.levels.ERROR)
		return
	end
	vim.fn.setenv('AVANTE_GEMINI_API_KEY', gemini_api_key)
	require('avante').setup(opts)
end

spec.dependencies = {
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/MunifTanjim/nui.nvim',
	'https://github.com/nvim-tree/nvim-web-devicons',
	--- The below dependencies are optional,
	'https://github.com/folke/snacks.nvim', -- for input provider snacks
	{
		-- support for image pasting
		'https://github.com/HakonHarnes/img-clip.nvim',
		event = 'VeryLazy',
		opts = {
			-- recommended settings
			default = {
				embed_image_as_base64 = false,
				prompt_for_file_name = false,
				drag_and_drop = {
					insert_mode = true,
				},
				-- required for Windows users
				use_absolute_path = true,
			},
		},
	},
}

return spec
