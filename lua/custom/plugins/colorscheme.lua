return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
            require("catppuccin").setup({
                no_italic = true,

                integrations = {
                    cmp = true,
                    gitsigns = true,
                    treesitter = true,
                    harpoon = true,
                    telescope = true,
                    mason = true,
                },
            })
        end,
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
