local map = require("utils.lazy").generate_map("", "LSP: ")
local vlb = vim.lsp.buf

local vt = false -- if virtual text of diagnostics is on

return {
    "neovim/nvim-lspconfig",
    event = { "LspAttach" },
    keys = {
        -- map("gd", "n", vlb.definition, "Go to definition")

        -- vlb.declaration, "Go to Declaration"
        -- vlb.type_definition, "Go to type definition"
        -- vlb.references, "Go to reference"
        -- vlb.implementation, "Go to implementation"

        -- map("<KEYBIND>", "n", vlb.code_action, "Code action")

        map("<leader>rn", "n", vlb.rename, "Rename"),

        map("K", "n", vlb.hover, "Hover Documentation"),
        map("<C-s>", { "n", "v", "i" }, vlb.signature_help, "Signature Help"),

        map("<leader>twa", "n", vlb.add_workspace_folder, "Workspace Add folder"),
        map("<leader>twr", "n", vlb.remove_workspace_folder, "Workspace remove Folder"),
        map("<leader>twl", "n", function() print(vim.inspect(vlb.list_workspace_folders())) end, "Workspace list Folders"),
        map("<leader>tf", "n", function() vlb.format { async = false } end, "Format current buffer"),

        map("<leader>tv", "n", function()
            vt = not vt
            vim.diagnostic.config({ virtual_text = vt, })
        end, "Toggle virtual text of diagnotics"),

        map("<leader>e", "n", vim.diagnostic.open_float, "Open floating diagnostic message"),
        map("[e", "n", vim.diagnostic.goto_prev, "Go to previous diagnostic message"),
        map("]e", "n", vim.diagnostic.goto_next, "Go to next diagnostic message"),
        map("<leader>tq", "n", vim.diagnostic.setloclist, "Open diagnostics list"),
    },
    config = function()
        vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>

        vim.diagnostic.config({
            signs = false,
            virtual_text = vt,
            float = { border = "rounded" },
        })

        require("lspconfig.ui.windows").default_options.border = "rounded"

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            group = vim.api.nvim_create_augroup("AutoFormatting", {}),
            callback = function()
                vim.lsp.buf.format({ async = false })
                vim.cmd("normal zz")
            end,
        })
    end,
}
