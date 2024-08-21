return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    requires = {
        { "nvim-lua/plenary.nvim" },
    },
    config = function()
        require("custom.harpoon")
    end,
}
