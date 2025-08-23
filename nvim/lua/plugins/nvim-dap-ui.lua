return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        require('dapui').setup();

        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        --vim.keymap.set("n", "<F8>", dap.continue, { desc = "Debug: Continue" })
        --vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
        --vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
        --vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
        --vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    end
}
