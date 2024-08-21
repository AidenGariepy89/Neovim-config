return {
    "Vonr/align.nvim",
    branch = "v2",
    lazy = true,
    init = function()
        local set = vim.keymap.set
        local align = require("align")

        set("x", "<leader>aa", function() align.align_to_char({ preview = false, length = 1 }) end, { desc = "Align to character" })
        set("x", "<leader>ap", function() align.align_to_char({ preview = true, length = 2 }) end, { desc = "Align to character (with Preview)" })
        set("x", "<leader>as", function() align.align_to_string({ preview = true, regex = false }) end, { desc = "Align to string" })
    end,
}
