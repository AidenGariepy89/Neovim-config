-- [[ Configure LSP ]]

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [a]ction")
    nmap("<leader>rr", vim.lsp.buf.references, "[R]efe[r]ences")
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

    nmap("gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")

    nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
    nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
    nmap("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
    nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostic list")
end

require("which-key").register {
    ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
    ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
    ["<leader>r"] = { name = "[R]ename" },
    ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
    ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
}

require("mason").setup()
require("mason-lspconfig").setup()

-- See :help lspconfig-setup
local servers = {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
    rust_analyzer = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
            },
        },
        filetypes = {
            "rust",
        },
    },
}

require("neodev").setup()

local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        })
    end,
}
-- Formaters
require("mason-tool-installer").setup({
    ensure_installed = {
        "black",
        "isort",
        "docformatter",
    },
})

local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.py" },
    desc = "Auto-format Python file after saving",
    callback = function()
        local file_name = vim.api.nvim_buf_get_name(0)
        vim.cmd(":silent !black --preview -q " .. file_name)
        vim.cmd(":silent !isort --profile black --float-to-top -q " .. file_name)
        vim.cmd(":silent !docformatter --in-place --black " .. file_name)
    end,
    group = autocmd_group,
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     pattern = { "*.rs" },
--     desc = "Auto-format Rust file after saving",
--     callback = function()
--         local file_name = vim.api.nvim_buf_get_name(0)
--         vim.cmd(":silent !cargo fmt")
--     end,
--     group = autocmd_group,
-- })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.go" },
    desc = "Auto-format Go file after saving",
    callback = function ()
        local file_name = vim.api.nvim_buf_get_name(0)
        vim.cmd(":silent !go fmt " .. file_name)
    end,
    group = autocmd_group,
})

-- LSPs
lspconfig.htmx.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "php" },
})

local util = require("lspconfig.util")

lspconfig.gdscript.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "gd", "gdscript", "gdscript3" },
    root_dir = util.root_pattern("project.godot", ".git"),
})

-- [[ Configure cmp ]]
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

require("aiden.snippets")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})
