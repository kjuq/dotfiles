return {
	'jinh0/eyeliner.nvim',
	keys = {
		{ "f",  mode = { "n", "x" } },
		{ "F",  mode = { "n", "x" } },
		{ "t",  mode = { "n", "x" } },
		{ "T",  mode = { "n", "x" } },
		{ "df", mode = { "n" } },
		{ "dF", mode = { "n" } },
		{ "dt", mode = { "n" } },
		{ "dT", mode = { "n" } },
	},
	opts = {
		highlight_on_key = true, -- this must be set to true for dimming to work!
		dim = true,
	},
}
