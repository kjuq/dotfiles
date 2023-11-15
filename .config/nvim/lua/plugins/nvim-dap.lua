local map = require("utils.lazy").generate_map("<leader>d", "Nvim-dap: ")
local mod = require("dap")

return {
    "mfussenegger/nvim-dap",
    keys = {
        map("B", "n", function() mod.set_breakpoint(vim.fn.input("BP condition: ")) end, "Breakpoint condition"),
        map("b", "n", function() mod.toggle_breakpoint() end, "Breakpoint"),
        map("c", "n", function() mod.continue() end, "Continue"),
        map("a", "n", function() mod.continue({ before = get_args }) end, "Run with args"),
        map("C", "n", function() mod.run_to_cursor() end, "Run to cursor"),
        map("g", "n", function() mod.goto_() end, "Go to line (no execute)"),
        map("i", "n", function() mod.step_into() end, "Step into"),
        map("j", "n", function() mod.down() end, "Down"),
        map("k", "n", function() mod.up() end, "Up"),
        map("l", "n", function() mod.run_last() end, "Run last"),
        map("o", "n", function() mod.step_out() end, "Step out"),
        map("O", "n", function() mod.step_over() end, "Step over"),
        map("p", "n", function() mod.pause() end, "Pause"),
        map("r", "n", function() mod.repl.toggle() end, "Toggle REPL"),
        map("s", "n", function() mod.session() end, "Session"),
        map("t", "n", function() mod.terminate() end, "Terminate"),
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
                ---@diagnostic disable-next-line: unused-local
                display_callback = function(variable, buf, stackframe, node, options)
                    if options.virt_text_pos == 'inline' then
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
