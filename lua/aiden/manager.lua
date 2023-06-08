local M = { }

M.update_neotree = function()
    if M.is_neotree_active == true and vim.fn.expand('%') ~= 'neo-tree filesystem [1]' then
        vim.cmd("Neotree show reveal_file=%")
    end
end

M.is_neotree_active = function()
    return require('neo-tree.ui.renderer').tree_is_visible(require('neo-tree.sources.manager').get_state('filesystem'))
end

return M
