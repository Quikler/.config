return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        "tailwind-tools",
        "onsails/lspkind-nvim",
    },
    config = function()
        local luasnip = require 'luasnip'
        local cmp = require 'cmp'
        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-S-K>'] = cmp.mapping.scroll_docs(-2),  -- Up
                ['<C-S-J>'] = cmp.mapping.scroll_docs(2),   -- Down
                ['<C-j>'] = cmp.mapping.select_next_item(), -- Down
                ['<C-k>'] = cmp.mapping.select_prev_item(), -- Down
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'async_path' },
            },
        }
    end,
    opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
    end,
}
