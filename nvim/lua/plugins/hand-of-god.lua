return {
    --"alucherdi/hand-of-god",
    --config = function()
        --local jumper = require('handofgod.jumper')
        --jumper.setup()

        ---- add file to jumper list
        --vim.keymap.set("n", "<leader>a", function() jumper.add() end)
        ---- explore jumper list as buffer
        --vim.keymap.set("n", "<leader>e", function() jumper:explore() end)

        ---- jump bindings
        --vim.keymap.set("n", "<leader>1", function() jumper.jump_to(1) end)
        --vim.keymap.set("n", "<leader>2", function() jumper.jump_to(2) end)
        --vim.keymap.set("n", "<leader>3", function() jumper.jump_to(3) end)
        --vim.keymap.set("n", "<leader>4", function() jumper.jump_to(4) end)

        --local manager = require('handofgod.manager')
        ---- file explorer/manager
        --vim.keymap.set("n", "<C-e>", function() manager:open() end)

        --local searcher = require('handofgod.searcher')
        --searcher:setup {
            --ignore = {
                --'node_modules', 'lib', 'libs', 'bin', 'build'
            --},
            ---- instead of: a/veeeeery/laaaaaaarge/paaaaaath/tooooooo/file.lua
            ---- you have:   a/v/l/p/t/file.lua
            ---- 64 char length to contract
            --contract_on_large_paths = true,
            --case_sensitive = false,
        --}

        --vim.keymap.set("n", "<C-p>", function() searcher:open() end)

        --local finder = require('handofgod.finder')
        --finder:setup {}
        --vim.keymap.set('n', '<C-f>', function() finder:open() end)
    --end
}
