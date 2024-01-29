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
        -- header = false,
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

    map("n", "<M-r>", vlb.rename, "Rename")

    -- map("n", "K", vlb.hover, "Hover Documentation") -- even without this, K is automatically mapped to see hover docs
    map({ "n", "v", "i" }, "<C-s>", vlb.signature_help, "Signature Help")

    map("n", "<M-w><M-a>", vlb.add_workspace_folder, "Add folder to workspace")
    map("n", "<M-w><M-r>", vlb.remove_workspace_folder, "Remove folder from workspace")
    map("n", "<M-w><M-w>", function() print(vim.inspect(vlb.list_workspace_folders())) end, "List folders of workspaceh")

    map("n", "<M-d>", function()
        vt = not vt
        vim.diagnostic.config({ virtual_text = virtual_text(vt), })
    end, "Toggle virtual text of diagnotics")

    -- Diagnostics
    map("n", "<M-e>", vim.diagnostic.open_float, "Show diagnostics")
    map("n", "[e", vim.diagnostic.goto_prev, "Go to prev diagnostics")
    map("n", "]e", vim.diagnostic.goto_next, "Go to next diagnostics")
    map("n", "<M-l>", vim.diagnostic.setloclist, "Set diagnostics into loclist")

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Format on save
    if client and client.supports_method("textDocument/formatting") then
        map("n", "gq", function()
            local winpos = vim.fn.winsaveview()
            vlb.format({ async = false })
            vim.fn.winrestview(winpos)
            vim.diagnostic.enable(0) -- fix not showing diagnostics after formatting, when it's fixed remove this keybind
        end, "Format current buffer")

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
