return {
    'ionide/Ionide-vim',
    lazy = true,
    config = function ()
        vim.g["fsharp#lsp_auto_setup"] = 0
        vim.g["fsharp#exclude_project_directories"] = { 'packet-files' }
    end
}
