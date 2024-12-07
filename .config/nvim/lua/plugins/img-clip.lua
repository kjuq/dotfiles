---@type LazySpec
local spec = { 'HakonHarnes/img-clip.nvim' }
spec.event = 'VeryLazy'

local map = require('utils.lazy').generate_map('', 'Img-clip: ')
spec.keys = {
	map('<Space>cP', 'n', '<Cmd>PasteImage<CR>', 'Paste image'),
}

spec.opts = {
	default = {
		dir_path = 'img', ---@type string | fun(): string
		relative_to_current_file = true, ---@type boolean | fun(): boolean
		prompt_for_file_name = false, ---@type boolean | fun(): boolean
		download_images = false, ---@type boolean | fun(): boolean
	},
}

return spec
