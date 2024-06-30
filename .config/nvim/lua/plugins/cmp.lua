-- To you prefer "noinsert", use the code below instead of `cmp.select_next_item()`
-- `cmp.select_next_item({ behavior = require("cmp.types").cmp.SelectBehavior.Select })`

local autocomplete = { "InsertEnter", "TextChanged" }

---@type LazySpec
local spec = { "hrsh7th/nvim-cmp" }

spec.event = { "InsertEnter", "CmdlineEnter" }

spec.config = function()
	-- max height of floating cmp window
	vim.opt.pumheight = 8

	local cmp = require("cmp")

	local copilot_source = cmp.config.sources({ { name = "copilot" } })
	local normal_sources = cmp.config.sources({
		{ name = "path" },
		{ name = "emoji" },
		{ name = "fish" },
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "natdat" },
	})

	local select_next = function()
		if cmp.visible() then
			cmp.select_next_item()
		else
			cmp.setup({
				sources = normal_sources,
				completion = { autocomplete = autocomplete },
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
				completion = { autocomplete = autocomplete },
			})
			cmp.complete()
		end
	end

	local abort = function(fallback)
		if cmp.visible() and vim.fn.pumvisible() ~= 1 then
			cmp.abort()
			cmp.setup({ completion = { autocomplete = false } })
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
		else
			cmp.open_docs()
		end
	end

	local confirm = function(fallback)
		if cmp.visible() then
			cmp.confirm({ select = false })
		else
			fallback()
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

	local utils = require("utils.common")
	local scrolldown = utils.floatscrolldown
	local scrollup = utils.floatscrollup

	local mapping_insert = {
		["<C-n>"] = cmp.mapping(select_next, { "i", "s" }),
		["<C-p>"] = cmp.mapping(select_prev, { "i", "s" }),
		[scrollup] = cmp.mapping(scroll_docs_up, { "i", "s" }),
		[scrolldown] = cmp.mapping(scroll_docs_down, { "i", "s" }),
		["<C-l>"] = cmp.mapping(abort, { "i", "s" }),
		["<C-e>"] = cmp.mapping(abort, { "i", "s" }),
		["<C-y>"] = cmp.mapping(confirm, { "i", "s" }),
		["<C-o>"] = cmp.mapping(toggle_docs, { "i", "s" }),
	}

	local mapping_cmdline = {
		["<C-n>"] = cmp.mapping(cmd_history_next, { "c" }),
		["<C-p>"] = cmp.mapping(cmd_history_prev, { "c" }),
		["<C-i>"] = cmp.mapping(select_next, { "c" }),
		["<S-Tab>"] = cmp.mapping(select_prev, { "c" }),
		["<C-l>"] = cmp.mapping(abort, { "c" }),
		["<C-e>"] = cmp.mapping(abort, { "c" }),
		["<C-y>"] = cmp.mapping(confirm, { "c" }),
		["<C-o>"] = cmp.mapping(toggle_docs, { "c" }),
	}

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noselect",
			autocomplete = autocomplete,
		},

		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},

		mapping = mapping_insert,

		sources = normal_sources,
		window = {
			completion = cmp.config.window.bordered({ border = require("utils.common").floatwinborder }),
			documentation = cmp.config.window.bordered({ border = require("utils.common").floatwinborder }),
		},
		---@diagnostic disable-next-line: missing-fields
		formatting = {
			format = require("lspkind").cmp_format({
				mode = "text_symbol", -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				symbol_map = { Copilot = "" },
			}),
		},
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = { { name = "git" } },
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = mapping_cmdline,
		sources = { { name = "buffer" } },
		completion = { autocomplete = false },
	})

	-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = mapping_cmdline,
		sources = {
			{ name = "path" },
			{ name = "cmdline" },
		},
		completion = { autocomplete = false },
	})

	-- enable only skkeleton sources
	local skkeleton_src = cmp.config.sources({ { name = "skkeleton" } })

	local function cmp_enable_skk()
		cmp.setup.buffer({ sources = skkeleton_src })
	end

	local function cmp_disable_skk()
		cmp.setup.buffer({ sources = normal_sources })
	end

	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = { "skkeleton-enable-pre", "eskk-enable-pre" },
		group = vim.api.nvim_create_augroup("skk-enable-pre", {}),
		callback = cmp_enable_skk,
	})

	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = { "skkeleton-disable-pre", "eskk-disable-pre" },
		group = vim.api.nvim_create_augroup("skk-disable-pre", {}),
		callback = cmp_disable_skk,
	})
end

spec.dependencies = {
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-emoji",
	"onsails/lspkind.nvim",
	"saadparwaiz1/cmp_luasnip",
	"mtoohey31/cmp-fish",
	{
		"petertriho/cmp-git",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		-- "zbirenbaum/copilot-cmp",
		"tris203/copilot-cmp",
		branch = "0.11_compat",
		opts = {},
	},
	{
		"Gelio/cmp-natdat",
		opts = {},
	},
}

return spec
