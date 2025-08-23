return {
    'preservim/nerdcommenter',
    lazy = false,
    priority = 10000,
    keys = {
        { '<leader>k', ':call nerdcommenter#Comment("i", "toggle")<CR>', mode = { 'n', 'v' } },
    },
}
