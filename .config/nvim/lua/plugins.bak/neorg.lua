return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    ft = "norg",
    cmd = "Neorg",
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {},  -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = {      -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/documents/__neorg",
                        },
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            local leader = keybinds.leader
                            keybinds.remap_key("norg", "n", "<C-Space>", leader .. "tt")
                            keybinds.remap_key("norg", "n", leader .. "id", leader .. "dt")
                        end,
                    },
                },
            },
        }
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
}