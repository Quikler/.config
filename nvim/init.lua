vim.g.mapleader = ' '
vim.g.do_filetype_lua = true
vim.g.hardtime_default_on = 1
local set = vim.opt
set.clipboard = 'unnamedplus'
set.number = true
set.tabstop = 4
set.shiftwidth = 0
set.expandtab = true
set.updatetime = 5000
set.relativenumber = true
vim.cmd([[ highlight Search ctermfg=0 ]])
vim.cmd([[ set termguicolors ]])
vim.opt.swapfile = false
vim.g.editorconfig = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

--local colorscheme = 'gruber-darker'
local colorscheme = 'kanagawa'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
    defaults = {
        lazy = false
    },
    install = {
        colorscheme = { colorscheme }
    }
})

local min = function(a, b)
    if a < b then
        return a
    end
    return b
end

print()

local yank_group = vim.api.nvim_create_augroup("yank highlight", { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    callback = function()
        if vim.v.event.operator == 'y' then
            local buf = vim.api.nvim_get_current_buf()
            local startpos = vim.api.nvim_buf_get_mark(buf, '[')
            local endpos = vim.api.nvim_buf_get_mark(buf, ']')
            local ns = vim.api.nvim_create_namespace('')
            local lines = vim.api.nvim_buf_get_lines(buf, endpos[1] - 1, endpos[1], false)
            local mark = vim.api.nvim_buf_set_extmark(buf, ns, startpos[1] - 1, startpos[2],
                { end_row = endpos[1] - 1, end_col = min(#(lines[1]), endpos[2] + 1), hl_group = 'Substitute' })
            local timer = vim.loop.new_timer()
            vim.loop.timer_start(timer, 250, 0, vim.schedule_wrap(function()
                vim.api.nvim_buf_del_extmark(buf, ns, mark)
            end))
        end
    end
})

--vim.keymap.set({ "n", "i", }, "<c-i>", "<cmd>bp<CR>", { desc = "go to previous buffer" })
--vim.keymap.set({ "n", "i", }, "<c-o>", "<cmd>bn<CR>", { desc = "go to next buffer" })

if vim.fn.has('nvim') == 1 then
    vim.fn.setenv("GIT_EDITOR", "nvr -cc split --remote-wait")
end

--vim.keymap.set("i", "<C-[>", "<Esc>", { desc = "Remap Esc key to Ctrl+[" })
vim.keymap.set("t", "<C-[>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })
--vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- quickfix list delete keymap
function Remove_qf_item()
    local curqfidx = vim.fn.line('.')
    local qfall = vim.fn.getqflist()

    -- Return if there are no items to remove
    if #qfall == 0 then return end

    -- Remove the item from the quickfix list
    table.remove(qfall, curqfidx)
    vim.fn.setqflist(qfall, 'r')

    -- Reopen quickfix window to refresh the list
    vim.cmd('copen')

    -- If not at the end of the list, stay at the same index, otherwise, go one up.
    local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx - 1, 1)

    -- Set the cursor position directly in the quickfix window
    local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
    vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
end

vim.cmd("command! RemoveQFItem lua Remove_qf_item()")
vim.api.nvim_command("autocmd FileType qf nnoremap <buffer> dd :RemoveQFItem<cr>")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            vim.cmd("cd " .. vim.fn.fnameescape(arg))
        end

        local path = vim.fn.expand("%:p:h")
        if vim.fn.isdirectory(path) == 1 then
            vim.cmd("lcd " .. path)
        end
    end,
})

local events = require("nvim-tree.events")
events.subscribe(events.Event.FileCreated, function(args)
    local full_path = args.fname
    local file_extension = full_path:match("[^.]+$")
    if file_extension == "cs" then
        --vim.api.nvim_echo({ { "Full path: " .. full_path } }, false, {})
        local filename = full_path:match("[^/]+$"):match("^[^\\.]+") -- a bit shit to use two match to get filename without extension but ok

        local parent = full_path:match("(.*[/\\])")
        vim.cmd(string.format(":silent !dotnet new class -o %s -n %s --force", parent, filename))
    end
end)

vim.cmd.colorscheme(colorscheme)
--vim.cmd [[ colorscheme catppuccin-macchiato ]]
--vim.cmd [[ colorscheme kanagawa-dragon ]]
