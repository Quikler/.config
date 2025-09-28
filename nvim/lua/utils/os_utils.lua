local M = {}

M.is_linux = vim.fn.has("unix") == 1
M.is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1

return M
