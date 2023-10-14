return {
    "mfussenegger/nvim-dap",
    lazy = false,
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
                -- dap.listeners.before.event_terminated["dapui_config"] = function()
                --     dapui.close()
                -- end
                -- dap.listeners.before.event_exited["dapui_config"] = function()
                --     dapui.close()
                -- end
                require("dapui").setup()
            end,
        },
    },
}
