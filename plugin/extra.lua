-- Terminal --

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})
local term_info = nil

local function new_terminal()
    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
    vim.cmd.term()

    return {
        buf = vim.api.nvim_get_current_buf(),
        channel = vim.bo.channel,
    }
end

local function open_terminal()
    if term_info == nil then
        term_info = new_terminal()
        return
    end

    if vim.fn.bufexists(term_info.buf) ~= 1 then
        term_info = new_terminal()
        return
    end

    local windows = vim.fn.win_findbuf(term_info.buf)
    if #windows > 0 then
        vim.api.nvim_set_current_win(windows[1])
        return
    end

    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
    vim.cmd.buffer(term_info.buf)
end

vim.keymap.set("n", "<leader>to", function()
    open_terminal()
end, { desc = "[t]erminal [o]pen" })

vim.keymap.set("n", "<leader>tm", function()
    open_terminal()
    if term_info ~= nil then
        local path = vim.fn.getcwd() .. "/build"
        vim.fn.chansend(term_info.channel, "cd " .. path .. "\n")
        vim.fn.chansend(term_info.channel, "make\n")
    end
end, { desc = "[t]erminal [m]ake" })
