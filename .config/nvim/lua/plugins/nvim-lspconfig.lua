return {
    "neovim/nvim-lspconfig",
    config = function()
        local vt_enabled = false
        vim.diagnostic.config({
            signs = false,
            virtual_text = vt_enabled,
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

                local map = function(mode, keys, func, description)
                    if description then
                        description = "LSP: " .. description
                    end

                    vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = description })
                end

                -- nmap("gd", vlb.definition, "[g]o to [d]efinition")
                -- nmap("<KEYBIND>", vlb.declaration, "[g]o to [D]eclaration")
                -- nmap("<KEYBIND>", vlb.type_definition, "Go to t[y]pe definition")
                -- nmap("<KEYBIND>", vlb.references, "Go to [r]eference")
                -- nmap("<KEYBIND>", vlb.implementation, "[g]o to [i]mplementation")

                -- nmap("<leader>la", vlb.code_action, "code [a]ction")

                map("n", "<leader>rn", vlb.rename, "[r]e[n]ame")

                map("n", "K", vlb.hover, "Hover Documentation")
                map("n", "<C-k>", vlb.signature_help, "Signature Documentation (Normal mode)")
                map("i", "<C-s>", vlb.signature_help, "Signature Documentation (Insert mode)")

                map("n", "<leader>lwa", vlb.add_workspace_folder, "[w]orkspace Add [f]older")
                map("n", "<leader>lwr", vlb.remove_workspace_folder, "[w]orkspace [r]emove Folder")
                map("n", "<leader>lwl",
                    function() print(vim.inspect(vlb.list_workspace_folders())) end,
                    "[w]orkspace [l]ist Folders")

                map("n", "<leader>lf", function() vlb.format { async = false } end, "[f]ormat current buffer with LSP")

                map("n", "<leader>lv", function()
                    vt_enabled = not vt_enabled
                    vim.diagnostic.config({ virtual_text = vt_enabled, })
                end, "Toggle [v]irtual text of diagnostics")
            end,
        })
        -- local desc = "LSP: Open floating diagnostic message"
        -- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = desc })
        -- desc = "LSP: Go to previous diagnostic message"
        -- vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = desc })
        -- desc = "LSP: Go to next diagnostic message"
        -- vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = desc })
        -- desc = "LSP: Open diagnostics list"
        -- vim.keymap.set("n", "<KEYBIND>", vim.diagnostic.setloclist, { desc = desc })
    end,
}
