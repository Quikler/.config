return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require('dap')

        -- Define breakpoint look
        --vim.fn.sign_define('DapBreakpoint', {text='󰪮', texthl='', linehl='', numhl=''})
        --vim.fn.sign_define('DapBreakpoint', { text = '󰽢', texthl = '', linehl = '', numhl = '' })

        vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
        vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
        vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
        vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

        vim.fn.sign_define('DapBreakpoint',
            {

                text = '', -- nerdfonts icon here
                -- text = '🔴', -- nerdfonts icon here
                texthl = 'DapBreakpointSymbol',
                linehl = 'DapBreakpoint',
                numhl = 'DapBreakpoint'
            })

        vim.fn.sign_define('DapStopped',
            {
                text = '', -- nerdfonts icon here
                texthl = 'yellow',
                linehl = 'DapBreakpoint',
                numhl = 'DapBreakpoint'
            })
        vim.fn.sign_define('DapBreakpointRejected',
            {
                text = '', -- nerdfonts icon here
                texthl = 'DapStoppedSymbol',
                linehl = 'DapBreakpoint',
                numhl = 'DapBreakpoint'
            })

        --vim.keymap.set("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>")

        -- This shit is recognized by nvim as Ctrl+F5
        vim.keymap.set("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>")
        --vim.keymap.set("n", "<F6>", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>")
        vim.keymap.set("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
        vim.keymap.set("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>")
        vim.keymap.set("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>")
        vim.keymap.set("n", "<F8>", "<Cmd>lua require'dap'.step_out()<CR>")

        -- For testing
        --vim.keymap.set("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>")
        --vim.keymap.set("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>")
        --vim.keymap.set("n", "<leader>dt", "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>",
        --{ noremap = true, silent = true, desc = 'debug nearest test' })

        -- C#
        local netcoredbg_adapter = {
            type = 'executable',
            command = '/sbin/netcoredbg',
            args = { '--interpreter=vscode' }
        }

        dap.adapters.coreclr = netcoredbg_adapter
        dap.adapters.netcoredbg = netcoredbg_adapter

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    --return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')

                    local M = {}

                    -- Find the root directory of a .NET project by searching for .csproj files
                    function M.find_project_root_by_csproj(start_path)
                        local Path = require("plenary.path")
                        local path = Path:new(start_path)

                        while true do
                            local csproj_files = vim.fn.glob(path:absolute() .. "/*.csproj", false, true)
                            if #csproj_files > 0 then
                                return path:absolute()
                            end

                            local parent = path:parent()
                            if parent:absolute() == path:absolute() then
                                return nil
                            end

                            path = parent
                        end
                    end

                    -- Find the highest version of the netX.Y folder within a given path.
                    function M.get_highest_net_folder(bin_debug_path)
                        local dirs = vim.fn.glob(bin_debug_path .. "/net*", false, true) -- Get all folders starting with 'net' in bin_debug_path

                        if dirs == 0 then
                            error("No netX.Y folders found in " .. bin_debug_path)
                        end

                        table.sort(dirs, function(a, b) -- Sort the directories based on their version numbers
                            local ver_a = tonumber(a:match("net(%d+)%.%d+"))
                            local ver_b = tonumber(b:match("net(%d+)%.%d+"))
                            return ver_a > ver_b
                        end)

                        return dirs[1]
                    end

                    -- Build and return the full path to the .dll file for debugging.
                    function M.build_dll_path()
                        local current_file = vim.api.nvim_buf_get_name(0)
                        local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

                        local project_root = M.find_project_root_by_csproj(current_dir)
                        if not project_root then
                            error("Could not find project root (no .csproj found)")
                        end

                        local csproj_files = vim.fn.glob(project_root .. "/*.csproj", false, true)
                        if #csproj_files == 0 then
                            error("No .csproj file found in project root")
                        end

                        local project_name = vim.fn.fnamemodify(csproj_files[1], ":t:r")
                        local bin_debug_path = project_root .. "/bin/Debug"
                        local highest_net_folder = M.get_highest_net_folder(bin_debug_path)
                        local dll_path = highest_net_folder .. "/" .. project_name .. ".dll"

                        print("Launching: " .. dll_path)
                        return dll_path
                    end

                    return M.build_dll_path();
                end,
            },
        }
    end
}
