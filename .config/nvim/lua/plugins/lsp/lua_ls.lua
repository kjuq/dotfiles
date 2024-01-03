---@return string[]
local get_plugin_paths = function()
    local result = {}
    local plugins = require("lazy.core.config").plugins
    for _, plugin in pairs(plugins) do
        if plugin._user_load_library or plugin.name == "lazy.nvim" then
            table.insert(result, vim.fs.joinpath(plugin.dir, "lua"))
        end
    end
    return result
end

---@return string[]
local library = function()
    local paths = get_plugin_paths()
    table.insert(paths, vim.fs.joinpath(vim.fn.stdpath("config"), "lua"))
    table.insert(paths, vim.fs.joinpath(vim.env.VIMRUNTIME, "lua"))
    table.insert(paths, "${3rd}/luv/library")
    table.insert(paths, "${3rd}/busted/library")
    table.insert(paths, "${3rd}/luassert/library")
    return paths
end

local common_opts = require("plugins/lsp/common")

local setup = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup(vim.tbl_deep_extend("error", common_opts, {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    pathStrict = true,
                    path = { "?.lua", "?/init.lua" },
                },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    checkThirdParty = "Disable",
                    library = library(),
                    -- library = vim.api.nvim_get_runtime_file("", true), -- This is a lot slower
                },
                -- format = { enable = false } , -- Use StyLua if disabled
                telemetry = { enable = false },
                hint = { enable = true },
            },
        },
    }))
end

return {
    setup = setup,
}

-- https://github.com/uhooi/dotfiles/blob/09d5f8f03974e4ef8ecf6641a0801d8b60271fca/.config/nvim/lua/plugins/config/nvim_lspconfig.lua
-- https://github.com/uhooi/dotfiles/blob/09d5f8f03974e4ef8ecf6641a0801d8b60271fca/.config/nvim/lua/plugins/config/lsp/lua_ls.lua
