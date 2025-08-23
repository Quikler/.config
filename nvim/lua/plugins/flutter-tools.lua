return {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    --config = true,
    config = function()
        require('flutter-tools').setup {}

        vim.keymap.set('n', '<F29>', "<cmd>FlutterRun<cr>", { noremap = true })
        vim.keymap.set('n', '<F6>', "<cmd>FlutterRestart<cr>", { noremap = true })

        local function reload_dartls_if_inactive()
            local dartls_client
            for _, client in ipairs(vim.lsp.get_clients()) do
                if client.name == "dartls" then
                    dartls_client = client
                    break
                end
            end

            vim.defer_fn(function()
                if dartls_client and not dartls_client.is_stopped() then
                    return
                end

                if dartls_client and dartls_client.stop then
                    dartls_client.stop()
                end

                require("flutter-tools.lsp").attach() -- <--- this line.
            end, 2000)
        end

        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.dart",
            callback = reload_dartls_if_inactive,
        })
    end,
}
