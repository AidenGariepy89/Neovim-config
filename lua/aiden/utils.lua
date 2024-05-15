local U = {}

function U.isMacOs()
    local baseDir = vim.api.nvim_list_runtime_paths()[1]
    local f = io.open(baseDir .. "/macos", "r")
    return f ~= nil and io.close(f)
end

function U.isLinux()
    local baseDir = vim.api.nvim_list_runtime_paths()[1]
    local f = io.open(baseDir .. "/linux", "r")
    return f ~= nil and io.close(f)
end

return U
