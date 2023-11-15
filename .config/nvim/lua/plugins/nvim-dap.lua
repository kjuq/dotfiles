local map = require("utils.lazy").generate_map("<leader>d", "Nvim-dap: ")
local dap = require("dap")

return {
    "mfussenegger/nvim-dap",
    keys = {
        map("B", "n", function() dap.set_breakpoint(vim.fn.input("BP condition: ")) end, "Breakpoint condition"),
        map("b", "n", function() dap.toggle_breakpoint() end, "Breakpoint"),
        map("c", "n", function() dap.continue() end, "Continue"),
        map("a", "n", function() dap.continue({ before = get_args }) end, "Run with args"),
        map("C", "n", function() dap.run_to_cursor() end, "Run to cursor"),
        map("g", "n", function() dap.goto_() end, "Go to line (no execute)"),
        map("i", "n", function() dap.step_into() end, "Step into"),
        map("j", "n", function() dap.down() end, "Down"),
        map("k", "n", function() dap.up() end, "Up"),
        map("l", "n", function() dap.run_last() end, "Run last"),
        map("o", "n", function() dap.step_out() end, "Step out"),
        map("O", "n", function() dap.step_over() end, "Step over"),
        map("p", "n", function() dap.pause() end, "Pause"),
        map("r", "n", function() dap.repl.toggle() end, "Toggle REPL"),
        map("s", "n", function() dap.session() end, "Session"),
        map("t", "n", function() dap.terminate() end, "Terminate"),
        map("w", "n", function() require("dap.ui.widgets").hover() end, "Widgets"),
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
    config = function()
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#CA4F4F" })
        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }) -- 󰧞 
    end,
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            keys = {
                { "<leader>dd", function() require("dapui").toggle() end, desc = "Nvim-dap-ui: Toggle" },
            },
            config = function()
                local dapui = require("dapui")
                dap.listeners.after.event_initialized["dapui_config"] = dapui.open
                dap.listeners.before.event_terminated["dapui_config"] = dapui.close
                dap.listeners.before.event_exited["dapui_config"] = dapui.close
                require("dapui").setup()
            end,
        },
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {
                ---@diagnostic disable-next-line: unused-local
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == "inline" then
                        return " = " .. variable.value
                    else
                        return "  " .. variable.name .. " = " .. variable.value
                    end
                end,
                virt_text_pos = "eol",
            }
        }
    },
}
