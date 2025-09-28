return {
    'neovim/nvim-lspconfig',
    dependencies = { 'folke/neodev.nvim', },
    lazy = false,
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        local lspconfig = require('lspconfig')
        local servers = { 'pylsp', 'lua_ls', 'html', 'cssls', 'clangd', --[['ts_ls',]] 'tailwindcss', --[['fsautocomplete']] }

        require('ionide').setup {
            capabilities = capabilities,
        }

        -- F# filetypes
        --vim.cmd [[ autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp ]]

        -- C# lsp extended
        --lspconfig['csharp_ls'].setup {
        --capabilities = capabilities,
        --handlers = {
        --["textDocument/definition"] = require('csharpls_extended').handler,
        --["textDocument/typeDefinition"] = require('csharpls_extended').handler,
        --},
        --cmd = { 'csharp-ls' },
        --}

        --require 'lspconfig'.csharp_ls.setup(lspconfig)
        --require("csharpls_extended").buf_read_cmd_bind()

        local path_utils = require("utils.path_utils")
        local home_env
        local appdata_local

        if require("utils.os_utils").is_linux then
            home_env = os.getenv("HOME")
            appdata_local = home_env .. "/.local/share"
        else
            home_env = os.getenv("USERPROFILE")
            appdata_local = os.getenv("LOCALAPPDATA")
        end

        vim.lsp.config("roslyn", {
            cmd = {
                "dotnet",
                path_utils.path_join(appdata_local, 'roslyn-lsp', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
                --appdata_local .. "/roslyn-lsp/Microsoft.CodeAnalysis.LanguageServer.dll",
                --("$HOME/.local/roslyn-lsp/Microsoft.CodeAnalysis.LanguageServer.dll"):gsub("%$(%w+)", os
                --.getenv),
                "--logLevel=Information",
                "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
                "--stdio",
            },
            -- Add other options here
        })

        -- Avalonia

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
            --vim.api.nvim_create_autocmd('BufRead', {
            pattern = { "*.axaml" },
            callback = function(event)
                vim.bo.filetype = 'xml'
                vim.lsp.start {
                    name = "avalonia",
                    --cmd = { "avalonia-ls" },
                    cmd = { "dotnet", "/home/quikler/.vscode/extensions/avaloniateam.vscode-avalonia-0.0.32/avaloniaServer/AvaloniaLanguageServer.dll" },
                    root_dir = vim.fn.getcwd(),
                    capabilities = capabilities,
                }
            end
        })
        vim.filetype.add({
            extension = {
                axaml = "xml",
            },
        })

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                capabilities = capabilities,
            }
        end
    end,
    keys = {
        { '<leader>cf', ':lua vim.lsp.buf.format()<CR>' },
        { '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', remap = false },
    }
}
