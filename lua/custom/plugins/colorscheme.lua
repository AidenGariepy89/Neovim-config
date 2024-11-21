return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("tokyonight-night")
        -- end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("gruvbox")
        -- end,
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        -- config = function ()
        --     vim.cmd.colorscheme("duskfox")
        -- end
    },
    {
        "AlexvZyl/nordic.nvim",
        priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("nordic")
        -- end,
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("kanagawa")
        -- end,
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                theme = "catppuccin-mocha",
                component_separators = '|',
                section_separators = '',
            },
        },
    },
}
