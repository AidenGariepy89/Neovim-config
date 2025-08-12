return {
    {
        "sainnhe/everforest",
        commit = "d84d9ec",
        priority = 1000,
        config = function()
            vim.g.everforest_disable_italic_comment = 1
            vim.g.everforest_dim_inactive_windows = 1
            vim.cmd.colorscheme("everforest")
        end,
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        commit = "a94fc68",
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_x = {
                        "encoding",
                        {
                            "fileformat",
                            symbols = {
                                unix = "lf",
                                dos = "crlf",
                                mac = "cr",
                            },
                        },
                        "filetype",
                    },
                },
                options = {
                    icons_enabled = true,
                    theme = "everforest",
                    component_separators = '',
                    section_separators = '',
                },
            })
        end,
    },
}
