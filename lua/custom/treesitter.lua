-- vim.cmd(":TSUpdate")

vim.defer_fn(function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "go", "lua", "rust", "python", "php", "bash", "javascript", "typescript", "tsx" },

        auto_install = true,
        modules = {},
        ignore_install = {},
        sync_install = false,

        highlight = {
            enable = true,
            disable = { "latex", "tex" },
        },
        indent = { enable = true },
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
end, 0)
