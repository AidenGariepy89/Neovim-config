require("fidget").setup({
    progress = {
        display = {
            done_icon = "",
        },
    },
    notification = {
        window = {
            border = "rounded",
        },
    },
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config("emmet_language_server", {
    filetypes = {
        "css",
        "eruby",
        "html",
        "htmldjango",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "typescriptreact",
        "php",
        "htmlangular",
    },
})

vim.lsp.enable("clangd", false)

vim.keymap.set("n", "K", function(opts)
    opts = opts or {}
    return vim.lsp.buf.hover(vim.tbl_deep_extend("force", opts, {
        border = "rounded",
    }))
end)

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
