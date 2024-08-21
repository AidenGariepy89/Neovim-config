vim.opt.shortmess:append "c"

local cmp = require("cmp")

local cmp_select = { behavior = cmp.SelectBehavior.Insert }

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "luasnip" },
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<C-Space>"] = cmp.mapping.complete({}),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
})

local ls = require("luasnip")
ls.config.set_config({
    history = false,
    updateevents = "TextChanged,TextChangedI",
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
    loadfile(ft_path)()
end

vim.keymap.set("i", "<C-K>", function()
    ls.expand()
end, { silent = true, desc = "" })

vim.keymap.set({ "i", "s" }, "<C-L>", function()
    ls.jump(1)
end, { silent = true, desc = "" })

vim.keymap.set({ "i", "s" }, "<C-H>", function()
    ls.jump(-1)
end, { silent = true, desc = "" })
