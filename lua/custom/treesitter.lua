-- vim.cmd(":TSUpdate")

vim.defer_fn(function()
    require("treesitter-context").disable()
    require("nvim-treesitter.configs").setup({
        auto_install = true,
        modules = {},
        ignore_install = {},
        ensure_installed = {},
        sync_install = false,

        highlight = {
            enable = true,
            disable = { "latex", "tex" },
        },
        
        indent = {
            enable = true,
            disable = { "c", "html" },
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                scope_incremental = "<c-s>",
                node_decremental = "<M-space>",
            },
        },
    })

    -- For `rustish` compiler.
    vim.filetype.add({
        extension = {
            ri = "rustish",
        }
    })
    vim.treesitter.language.register("rust", "rustish")

end, 0)
