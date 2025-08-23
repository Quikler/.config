return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = function()
                local prev_buf = vim.fn.bufname("#")
                local curr_buf = vim.fn.bufname("%")
                local win_count = vim.fn.winnr("$")

                if string.match(prev_buf, "NvimTree") and
                    not string.match(curr_buf, "NvimTree") and
                    win_count > 1
                then
                    vim.cmd("normal! <C-^>")
                end
            end
        })

        require("nvim-tree").setup {
            filters = { dotfiles = false },
            disable_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 30,
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                indent_markers = { enable = true },
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                        },
                        git = { unmerged = "" },
                    },
                },
            },
            git = {
                enable = true,
                ignore = false,
            },
        }
    end,
}
