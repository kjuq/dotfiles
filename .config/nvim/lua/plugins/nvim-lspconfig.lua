return {
    "neovim/nvim-lspconfig",
    config = function()
        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions

        -- local desc = "LSP: Open floating diagnostic message"
        -- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = desc })
        -- desc = "LSP: Go to previous diagnostic message"
        -- vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = desc })
        -- desc = "LSP: Go to next diagnostic message"
        -- vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = desc })
        -- desc = "LSP: Open diagnostics list"
        -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = desc })

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)

                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions

                local vlb = vim.lsp.buf

                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
                end

                -- nmap("gd", vlb.definition, "[g]o to [d]efinition")
                -- nmap("gD", vlb.declaration, "[g]o to [D]eclaration")
                -- nmap("<leader>td", vlb.type_definition, "Go to [t]ype [d]efinition")
                -- -- reference has alternatives. telescope, lspsaga, and etc.
                -- nmap("<leader>rf", vlb.references, "Go to [r]e[f]erence")
                -- nmap("<leader>im", vlb.implementation, "[g]o to [i]mplementation")

                -- nmap("<leader>ca", vlb.code_action, "[c]ode [a]ction")

                -- nmap("<leader>rn", vlb.rename, "[r]e[n]ame")

                -- nmap("K", vlb.hover, "Hover Documentation")
                nmap("<C-k>", vlb.signature_help, "Signature Documentation")

                nmap("<leader>wa", vlb.add_workspace_folder, "[w]orkspace Add [f]older")
                nmap("<leader>wr", vlb.remove_workspace_folder, "[w]orkspace [r]emove Folder")
                nmap(
                    "<leader>wl",
                    function() print(vim.inspect(vlb.list_workspace_folders())) end,
                    "[w]orkspace [l]ist Folders"
                )

                nmap(
                    "<leader>Lf",
                    function() vlb.format { async = false } end,
                    "[f]ormat current buffer with LSP"
                )
            end,
        })
        vim.diagnostic.config({
            signs = false,
        })
    end,
}


