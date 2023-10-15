return {
    "mfussenegger/nvim-dap",
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Nvim-dap: [B]reakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Nvim-dap: Toggle [b]reakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Nvim-dap: [c]ontinue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Nvim-dap: Run with [a]rgs" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Nvim-dap: Run to [C]ursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Nvim-dap: [g]o to line (no execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Nvim-dap: Step [i]nto" },
        { "<leader>dj", function() require("dap").down() end, desc = "Nvim-dap: Down [j]" },
        { "<leader>dk", function() require("dap").up() end, desc = "Nvim-dap: Up [k]" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Nvim-dap: Run [l]ast" },
        { "<leader>do", function() require("dap").step_out() end, desc = "Nvim-dap: Step [o]ut" },
        { "<leader>dO", function() require("dap").step_over() end, desc = "Nvim-dap: Step [O]ver" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Nvim-dap: [p]ause" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Nvim-dap: Toggle [r]EPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Nvim-dap: [s]ession" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Nvim-dap: [t]erminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Nvim-dap: [w]idgets" },
    },
    cmd = {
        "DapContinue",
        "DapInstall",
        "DapLoadLaunchJSON",
        "DapRestartFrame",
        "DapSetLogLevel",
        "DapShowLog",
        "DapStepInto",
        "DapStepOut",
        "DapStepOver",
        "DapTerminate",
        "DapToggleBreakpoint",
        "DapToggleRepl",
        "DapUninstall",
        "DapVirtualTextDisable",
        "DapVirtualTextEnable",
        "DapVirtualTextForceRefresh",
        "DapVirtualTextToggle",
    },
    config = function ()
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#CA4F4F" })
        vim.fn.sign_define("DapBreakpoint", {text="", texthl="DapBreakpoint", linehl="", numhl=""}) -- 󰧞 
    end,
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            keys = {
                { "<leader>dd", function() require("dapui").toggle() end, desc = "Nvim-dap-ui: Toggle" },
            },
            config = function ()
                local dap, dapui = require("dap"), require("dapui")
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close()
                end
                require("dapui").setup()
            end,
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {
                -- enabled = true,                        -- enable this plugin (the default)
                -- enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                -- highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                -- highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                -- show_stop_reason = true,               -- show stop reason when stopped for exceptions
                -- commented = false,                     -- prefix virtual text with comment string
                -- only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
                -- all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
                -- clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)

                --- A callback that determines how a variable is displayed or whether it should be omitted
                --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
                --- @param buf number
                --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
                --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
                --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
                --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == 'inline' then
                        return " = " .. variable.value
                    else
                        return "  " .. variable.name .. " = " .. variable.value
                    end
                end,
                -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
                virt_text_pos = "eol",

                -- experimental features:
                -- all_frames = true,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                -- virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
                -- virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                -- -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
            }
        }
    },
}
