local vt = false -- if virtual text of diagnostics is on
vim.diagnostic.config({
    signs = false,
    virtual_text = vt,
    float = { border = "rounded" },
})

local callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Keymaps for LSP
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = bufnr })
    end

    local vlb = vim.lsp.buf

    -- LspSaga provides same functionalities
    --
    -- map("n", "gd", vlb.definition, "Go to definition")
    -- vlb.declaration, "Go to Declaration"
    -- vlb.type_definition, "Go to type definition"
    -- vlb.references, "Go to reference"
    -- vlb.implementation, "Go to implementation"
    -- map("n", "<KEYBIND>", vlb.code_action, "Code action")

    map("n", "<leader>rn", vlb.rename, "Rename")

    map("n", "K", vlb.hover, "Hover Documentation")
    map({ "n", "v", "i" }, "<C-s>", vlb.signature_help, "Signature Help")

    map("n", "<leader>twa", vlb.add_workspace_folder, "Workspace Add folder")
    map("n", "<leader>twr", vlb.remove_workspace_folder, "Workspace remove Folder")
    map("n", "<leader>twl", function() print(vim.inspect(vlb.list_workspace_folders())) end, "Workspace list Folders")
    map("n", "<leader>tf", function() vlb.format { async = false } end, "Format current buffer")

    map("n", "<leader>tv", function()
        vt = not vt
        vim.diagnostic.config({ virtual_text = vt, })
    end, "Toggle virtual text of diagnotics")

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Format on save
    if client and client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("AutoFormatting", {}),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = callback,
})
