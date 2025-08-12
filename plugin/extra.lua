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

---@param open_prev boolean
---@param save_instance boolean
local function open_terminal(open_prev, save_instance)
    local term;

    if open_prev then
        term = term_info
        if term == nil then
            term = new_terminal()
        end

        if vim.fn.bufexists(term.buf) ~= 1 then
            term = new_terminal()
        end
    else
        term = new_terminal()
    end

    if save_instance then
        term_info = term
    end

    local windows = vim.fn.win_findbuf(term.buf)

    if #windows > 0 then
        vim.api.nvim_set_current_win(windows[1])
        return
    end

    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
    vim.cmd.buffer(term.buf)

    return term
end

vim.keymap.set("n", "<leader>to", function()
    open_terminal(true, true)
end, { desc = "[t]erminal [o]pen" })

vim.keymap.set("n", "<leader>b", function()
    vim.cmd("botright split | resize 10 | terminal ninja -C build")
end, { desc = "Build C project with Ninja" })
