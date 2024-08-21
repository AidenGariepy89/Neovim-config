return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "folke/neodev.nvim",
        -- "whoissethdaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("custom.lsp")
    end,
}
