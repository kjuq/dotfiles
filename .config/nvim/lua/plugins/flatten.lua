return {
	"willothy/flatten.nvim",
	event = { "BufWinEnter" },
	init = function()
		_G._user_flatten_number = vim.o.number
		_G._user_flatten_relativenumber = vim.o.relativenumber
	end,
	opts = {
		callbacks = {
			post_open = function()
				vim.opt.number = _G._user_flatten_number
				vim.opt.relativenumber = _G._user_flatten_relativenumber
			end,
		},
	},
}
