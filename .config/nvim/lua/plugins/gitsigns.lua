return {
	"lewis6991/gitsigns.nvim",
	event = require("utils.lazy").verylazy,
	opts = {
		signcolumn = false,
		numhl = true,
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc, opts)
				opts = opts or {}
				opts.buffer = bufnr
				opts.desc = "Gitsigns: " .. desc
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]g", function()
				if vim.wo.diff then
					return "]g"
				end
				vim.schedule(function() gs.next_hunk() end)
				return "<Ignore>"
			end, "Go to next hunk", { expr = true })

			map("n", "[g", function()
				if vim.wo.diff then
					return "[g"
				end
				vim.schedule(function() gs.prev_hunk() end)
				return "<Ignore>"
			end, "Go to next hunk", { expr = true })

			-- Actions
			map("n", "<leader>gh", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>gh", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, "Stage hunk")
			map("v", "<leader>gr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, "Reset hunk")
			map("n", "<leader>gs", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
			map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
			map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>gb", function() gs.blame_line { full = true } end, "Blame line")
			map("n", "<leader>gT", gs.toggle_current_line_blame, "Toggle current line blame")
			map("n", "<leader>gd", gs.diffthis, "Diff this")
			map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this \"~\" <- ?")
			map("n", "<leader>gt", gs.toggle_deleted, "Toggle deleted")

			-- Text object
			map({ "o", "x" }, "<leader>gS", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
		end
	},
}
