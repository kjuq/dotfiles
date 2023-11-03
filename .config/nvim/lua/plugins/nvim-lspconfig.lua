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

                local nmap = function(keys, func, description)
                    if description then
                        description = "LSP: " .. description
                    end

                    vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = description })
                end

                -- nmap("gd", vlb.definition, "[g]o to [d]efinition")
                -- nmap("gD", vlb.declaration, "[g]o to [D]eclaration")
                -- nmap("gy", vlb.type_definition, "Go to t[y]pe definition")
                -- nmap("<leader>lr", vlb.references, "Go to [r]eference")
                -- nmap("<leader>li", vlb.implementation, "[g]o to [i]mplementation")

                -- nmap("<leader>ca", vlb.code_action, "[c]ode [a]ction")

                nmap("<leader>rn", vlb.rename, "[r]e[n]ame")

                nmap("K", vlb.hover, "Hover Documentation")
                nmap("<C-k>", vlb.signature_help, "Signature Documentation")

                nmap("<leader>lwa", vlb.add_workspace_folder, "[w]orkspace Add [f]older")
                nmap("<leader>lwr", vlb.remove_workspace_folder, "[w]orkspace [r]emove Folder")
                nmap(
                    "<leader>lwl",
                    function() print(vim.inspect(vlb.list_workspace_folders())) end,
                    "[w]orkspace [l]ist Folders"
                )

                nmap(
                    "<leader>lf",
                    function() vlb.format { async = false } end,
                    "[f]ormat current buffer with LSP"
                )

                nmap(
                    "<leader>lv",
                    function()
                        vt_enabled = not vt_enabled
                        vim.diagnostic.config({
                            virtual_text = vt_enabled,
                        })
                    end,
                    "Toggle [v]irtual text of diagnostics"
                )
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
