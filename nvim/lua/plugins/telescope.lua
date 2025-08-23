return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim'
    },
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopeResults",
            callback = function(ctx)
                vim.api.nvim_buf_call(ctx.buf, function()
                    vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                    vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                end)
            end,
        })

        local function filenameFirst(_, path)
            local tail = vim.fs.basename(path)
            local parent = vim.fs.dirname(path)
            if parent == "." then return tail end
            return string.format("%s\t\t%s", tail, parent)
        end

        require('telescope').setup {
            pickers = {
                find_files = {
                    path_display = filenameFirst,
                },
                live_grep = {
                    path_display = filenameFirst,
                },
                buffers = {
                    path_display = filenameFirst,
                },
                git_files = {
                    path_display = filenameFirst,
                },
                lsp_references = {
                    path_display = filenameFirst,
                }
            },
            defaults = {
                file_ignore_patterns = { "node_modules/", ".git/", "%.dll", "%.cache", "%.pdb", },
                mappings = {
                    n = {
                        ['<c-r>'] = require('telescope.actions').delete_buffer,
                        ['<c-j>'] = require('telescope.actions').move_selection_next,
                        ['<c-k>'] = require('telescope.actions').move_selection_previous,
                    },
                    i = {
                        ['<c-r>'] = require('telescope.actions').delete_buffer,
                        ['<c-j>'] = require('telescope.actions').move_selection_next,
                        ['<c-k>'] = require('telescope.actions').move_selection_previous,
                    }
                }
            },
        }

        require('telescope').load_extension('ui-select')
        require('telescope').load_extension('live_grep_args')
        --require("telescope").load_extension("grapple")

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end, { desc = 'Telescope find files' })
        vim.keymap.set("n", "<leader>fg", require('telescope').extensions.live_grep_args.live_grep_args,
            { desc = 'Telescope live grep with args' })
        --vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope references' })
        vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Telescope implementations' })
        vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = 'Telescope definitions' })
        vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Telescope current buffer fzf' })

        --vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
}
