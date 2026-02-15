return {
    "neovim/nvim-lspconfig",
    tag = "v2.4.0",
    dependencies = {
        {
            "mason-org/mason.nvim",
            tag = "v2.1.0",
            opts = {},
        },
        {
            "mason-org/mason-lspconfig.nvim",
            tag = "v2.1.0",
            opts = {},
        },
        {
            "j-hui/fidget.nvim",
            tag = "v1.6.1",
            opts = {},
        },
    },
    config = function()
        require("custom.lsp")
    end,
}
