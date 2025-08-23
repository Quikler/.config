return {
    --'stevearc/conform.nvim',
    --opts = {},
    --config = function()
    --require("conform").setup({
    --formatters_by_ft = {
    --javascript = { "prettier" },
    --typescript = { "prettier" },
    --javascriptreact = { "prettier" },
    --typescriptreact = { "prettier" },
    --},
    --format_on_save = {
    --async = true,
    --timeout_ms = 500,
    --lsp_fallback = true,
    --},
    --})

    --vim.keymap.set('n', '<leader>cf', function()
    --local curr_buf = vim.api.nvim_get_current_buf()
    --require 'conform'.format({ bufnr = curr_buf })
    --end)
    --end
}
