return {
    "neovim/nvim-lspconfig",
    config = function()
        local map = function(mode, keys, func, description, buffer)
            if description then
                description = "LSP: " .. description
            end

            local opts = {}
            if not buffer == nil then
                opts.buffer = buffer
            end
            opts.desc = description

            vim.keymap.set(mode, keys, func, opts)
        end
        local vt_enabled = false
        vim.diagnostic.config({
            signs = false,
            virtual_text = vt_enabled,
            float = { border = "rounded" },
        })
        require('lspconfig.ui.windows').default_options.border = "rounded"

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.api.nvim_create_augroup("AutoFormatting", {})
                vim.api.nvim_create_autocmd("BufWritePre", {
                    pattern = "*",
                    group = "AutoFormatting",
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })

                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local vlb = vim.lsp.buf

                -- map("n", "gd", vlb.definition, "Go to definition", ev.buf)

                -- vlb.declaration, "Go to Declaration"
                -- vlb.type_definition, "Go to type definition"
                -- vlb.references, "Go to reference"
                -- vlb.implementation, "Go to implementation"

                -- map("n", "<leader>la", vlb.code_action, "code [a]ction", ev.buf)

                map("n", "<leader>rn", vlb.rename, "Rename", ev.buf)

                map("n", "K", vlb.hover, "Hover Documentation", ev.buf)
                map({ "n", "v", "i" }, "<C-s>", vlb.signature_help, "Signature Documentation", ev.buf)

                map("n", "<leader>twa", vlb.add_workspace_folder, "Workspace Add folder", ev.buf)
                map("n", "<leader>twr", vlb.remove_workspace_folder, "Workspace remove Folder", ev.buf)
                map("n", "<leader>twl", function() print(vim.inspect(vlb.list_workspace_folders())) end,
                    "Workspace list Folders", ev.buf)

                map("n", "<leader>tf", function() vlb.format { async = false } end, "Format current buffer", ev.buf)

                map("n", "<leader>tv", function()
                    vt_enabled = not vt_enabled
                    vim.diagnostic.config({ virtual_text = vt_enabled, })
                end, "Toggle virtual text of diagnostics", ev.buf)
            end,
        })
        map("n", "<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
        map("n", "[e", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
        map("n", "]e", vim.diagnostic.goto_next, "Go to next diagnostic message")
        map("n", "<leader>tq", vim.diagnostic.setloclist, "Open diagnostics list")
    end,
}
