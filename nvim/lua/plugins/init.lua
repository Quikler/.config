return {
    'saadparwaiz1/cmp_luasnip',
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
    'tpope/vim-abolish',
    'hrsh7th/cmp-nvim-lsp',
    'Decodetalkers/csharpls-extended-lsp.nvim',
    'cohama/lexima.vim',
    'luochen1990/rainbow',
    'FelipeLema/cmp-async-path',
    'nvim-telescope/telescope-ui-select.nvim',
    'takac/vim-hardtime',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                sections = {
                    lualine_b = {
                        {
                            'grapple',
                        },
                    },
                },
                options = {
                    theme = 'auto'
                },
            })
        end
    },
}
