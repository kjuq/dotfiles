return {
    "lewis6991/gitsigns.nvim",
    event = { "VeryLazy" },
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
            map(
                "n", "]g",
                function()
                    if vim.wo.diff then
                        return "]g"
                    end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end,
                "Go to next hunk",
                { expr = true }
            )

            map(
                "n", "[g",
                function()
                    if vim.wo.diff then
                        return "[g"
                    end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end,
                "Go to next hunk",
                { expr = true }
            )

            -- Actions
            map("n", "<leader>gh", gs.stage_hunk, "Stage [h]unk")
            map("n", "<leader>gr", gs.reset_hunk, "[r]eset hunk")
            map("v", "<leader>gh", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, "Stage [h]unk")
            map("v", "<leader>gr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end, "[r]eset hunk")
            map("n", "<leader>gs", gs.stage_buffer, "[s]tage buffer")
            map("n", "<leader>gu", gs.undo_stage_hunk, "[u]ndo stage hunk")
            map("n", "<leader>gR", gs.reset_buffer, "[R]eset buffer")
            map("n", "<leader>gp", gs.preview_hunk, "[p]review hunk")
            map("n", "<leader>gb", function() gs.blame_line{full=true} end, "[b]lame line")
            map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle current line [B]lame")
            map("n", "<leader>gd", gs.diffthis, "Diff this")
            map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff this \"~\" <- ?")
            map("n", "<leader>gt", gs.toggle_deleted, "[t]oggle deleted")

            -- Text object
            map({"o", "x"}, "<leader>gS", ":<C-U>Gitsigns select_hunk<CR>", "[s]elect hunk")
        end
    },
}



