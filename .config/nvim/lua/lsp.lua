local virtual_text = function(enable)
    if enable then
        return {
            format = function(diagnostic)
                return string.format("%s (%s) [%s]", diagnostic.message, diagnostic.source, diagnostic.code)
            end
        }
    else
        return false
    end
end

local vt = false -- if virtual text of diagnostics is on

vim.diagnostic.config({
    signs = false,
    virtual_text = virtual_text(vt),
    float = {
        border = require("utils.lazy").floatwinborder,
        header = false,
        format = function(diagnostic)
            return string.format("%s\n⊳ %s", diagnostic.message, diagnostic.source)
        end
    },
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
    -- vlb.declaration, "Go to Declaration"
    -- vlb.type_definition, "Go to type definition"
    -- vlb.references, "Go to reference"
    -- vlb.implementation, "Go to implementation"
    -- map("n", "<KEYBIND>", vlb.code_action, "Code action")

    map("n", "gd", vlb.definition, "Go to definition")

    map("n", "<leader>rn", vlb.rename, "Rename")

    map("n", "K", vlb.hover, "Hover Documentation")
    map({ "n", "v", "i" }, "<C-s>", vlb.signature_help, "Signature Help")

    map("n", "<leader>twa", vlb.add_workspace_folder, "Workspace Add folder")
    map("n", "<leader>twr", vlb.remove_workspace_folder, "Workspace remove Folder")
    map("n", "<leader>twl", function() print(vim.inspect(vlb.list_workspace_folders())) end, "Workspace list Folders")
    map("n", "<leader>tf", function()
        local winpos = vim.fn.winsaveview()
        vlb.format({ async = false })
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.fn.winrestview(winpos)
        vim.diagnostic.enable(0) -- fix not showing diagnostics after formatting
    end, "Format current buffer")

    map("n", "<leader>tv", function()
        vt = not vt
        vim.diagnostic.config({ virtual_text = virtual_text(vt), })
    end, "Toggle virtual text of diagnotics")

    -- Diagnostics
    map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
    map("n", "[e", vim.diagnostic.goto_prev, "Go to prev diagnostics")
    map("n", "]e", vim.diagnostic.goto_next, "Go to next diagnostics")
    map("n", "<leader>E", vim.diagnostic.setloclist, "Set diagnostics into loclist")

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Format on save
    if client and client.supports_method("textDocument/formatting") then
        local winpos
        local group = vim.api.nvim_create_augroup("AutoFormatting", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
                winpos = vim.fn.winsaveview()
                vim.lsp.buf.format({ async = false })
            end,
        })
        vim.api.nvim_create_autocmd("BufWritePost", {
            group = group,
            buffer = bufnr,
            callback = function()
                vim.diagnostic.enable(0)   -- fix not showing diagnostics after formatting
                vim.fn.winrestview(winpos) -- restore cursor position
            end,
        })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = callback,
})
