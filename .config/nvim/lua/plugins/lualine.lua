return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = { "CursorHold" },
    opts = function ()
        local function show_macro_recording()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
                return ""
            else
                return "Recording @" .. recording_register
            end
        end

        return {
            options = {
                globalstatus = true,
                theme = "material",
                refresh = {
                    statusline = 10,
                },
            },
            sections = {
                lualine_x = {
                    {
                        "macro-recording",
                        fmt = show_macro_recording,
                        color = { fg = "#ff9e64" },
                    },
                },
            },
        }
    end,
}


