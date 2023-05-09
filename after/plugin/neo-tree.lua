-- vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')
vim.keymap.set('n', '<leader>pv', '<cmd>Neotree toggle<cr>')
vim.keymap.set('n', '<leader>o', function()
    if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
    else
        vim.cmd.Neotree "focus"
    end
end)

require('neo-tree').setup({
    window = {
        width = 30,
    }
})
