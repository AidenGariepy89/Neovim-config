local lspconfig = require("lspconfig")

local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
)

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

require("fidget").setup({})
require("neodev").setup()
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
    },

    handlers = {
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end,

        zls = function()
            lspconfig.zls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                settings = {
                    zls = {
                        warn_style = false
                    },
                },
            })
            vim.g.zig_fmt_parse_errors = 0
            vim.g.zig_fmt_autosave = 0
        end,

        lua_ls = function()
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })
        end,

        emmet_language_server = function()
            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
                on_attach = on_attach,
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
        end,
    },
})
