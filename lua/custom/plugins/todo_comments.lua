return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- opts = {
    config = function()
        require("todo-comments").setup({
            signs = false,
            keywords = {
                TODO = { icon = "T", color = "error" },
                NOTE = { icon = "N", color = "hint" },
                FIX = {
                    icon = "F",
                    color = "warning",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
            },
            merge_keywords = false,
            highlight = {
                before = "",
                keyword = "bg",
                after = "bg",
                pattern = [[.*<(KEYWORDS)[^ ]*:]],
            },
            search = {
                pattern = [[\b(KEYWORDS)[^ ]*:]],
            },
        })
    end,
}
