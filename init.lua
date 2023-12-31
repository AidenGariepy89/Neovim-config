vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Lazy ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    "mbbill/undotree",

    { -- LSP
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "whoissethdaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} },
            "folke/neodev.nvim",
        },
    },

    { -- Completion
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            "hrsh7th/cmp-nvim-lsp",

            "rafamadriz/friendly-snippets",
        },
    },

    { "folke/which-key.nvim",  opts = {} },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                no_italic = true,
                dim_inactive = {
                    enabled = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = 'catppuccin',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    { "numToStr/Comment.nvim", opts = {} },

    { -- Treesitter
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        "nvim-treesitter/nvim-treesitter-context",
    },

    { -- Telescope
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
        },
    },

    "theprimeagen/harpoon",

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "Preview git hunk" })

                local gs = package.loaded.gitsigns
                vim.keymap.set({ "n", "v" }, "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ "n", "v" }, "[c", function ()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
        },
    },
}, {})

-- [[ Settings ]]

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.guicursor = ""

vim.opt.mouse = "nv"

-- [[ Keymaps ]]

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open explorer" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo tree" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[p]aste and don't yank" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[d]elete and don't yank" })
vim.keymap.set("n", "<C-Space>", "")
vim.keymap.set("n", "q:", "") -- get rid of that pesky menu

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Locator list next" })
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Locator list prev" })

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Edit word under cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

vim.keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement" })

-- [[ Colors ]]
local transparent_bg = false
local function swap_bg()
    if transparent_bg then
        require("catppuccin").setup({
            transparent_background = false,
            flavour = "mocha",
            no_italic = true,
            dim_inactive = {
                enabled = true,
            },
        })
        vim.cmd.colorscheme("catppuccin")

        transparent_bg = false
    else
        require("catppuccin").setup({
            transparent_background = true,
            flavour = "mocha",
            no_italic = true,
            dim_inactive = {
                enabled = true,
            },
        })
        vim.cmd.colorscheme("catppuccin")

        transparent_bg = true
    end
end
vim.api.nvim_create_user_command("SwapBG", swap_bg, {})
vim.keymap.set("n", "<leader>bg", "<cmd>SwapBG<cr>")

-- [[ Configure LuaSnip ]]

vim.keymap.set("i", "<C-K>", function()
    require("luasnip").expand()
end, { silent = true, desc = "" })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
    require("luasnip").jump(1)
end, { silent = true, desc = "" })
vim.keymap.set({ "i", "s" }, "<C-H>", function()
    require("luasnip").jump(-1)
end, { silent = true, desc = "" })

-- [[ Configure Fugitive ]]

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gl", "<cmd>Git log --oneline<cr>")
vim.keymap.set("n", "<leader>gf", "<cmd>Git fetch<cr>")

local fugitive = vim.api.nvim_create_augroup("Fugitive", {})
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git("push")
        end, opts)
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git("pull --rebase")
        end, opts)
        vim.keymap.set("n", "<leader>t", ":Git push -u origin main", opts)
    end,
})

-- [[ Configure Harpoon ]]

vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file, { desc = "[A]dd file to harpoon" })
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu, { desc = "Toggl[e] harpoon menu" })
vim.keymap.set("n", "<C-h>", function() require("harpoon.ui").nav_file(1) end, { desc = "File 1" })
vim.keymap.set("n", "<C-t>", function() require("harpoon.ui").nav_file(2) end, { desc = "File 2" })
vim.keymap.set("n", "<C-n>", function() require("harpoon.ui").nav_file(3) end, { desc = "File 3" })
vim.keymap.set("n", "<C-s>", function() require("harpoon.ui").nav_file(4) end, { desc = "File 4" })

-- [[ Configure Telescope ]]
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
})

pcall(require("telescope").load_extension, "fzf")

local function find_git_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    if current_file == "" then
        current_dir = cwd
    else
        current_dir = vim.fn.fnamemodify(current_file, ":h")
    end

    local git_root = vim.fn.systemlist("git -C" .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching on current working directory")
        return cwd
    end
    return git_root
end

local function is_git()
    vim.fn.system("git status")
    if vim.v.shell_error ~= 0 then
        return false
    end
    return true
end

local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require("telescope.builtin").live_grep({
            search_dirs = {git_root},
        })
    end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in open buffer" })

vim.keymap.set("n", "<C-p>", function()
    if is_git() then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
    end
end, { desc = "Search files (Git if available)" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<CR>", { desc = "[S]earch [G]rep Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

-- [[ Configure Treesitter ]]
vim.defer_fn(function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "go", "lua", "rust", "python", "php", "bash", "javascript", "typescript", "tsx" },

        auto_install = true,
        modules = {},
        ignore_install = {},
        sync_install = false,

        highlight = { enable = true },
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup({
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
        local fileName = vim.api.nvim_buf_get_name(0)
        vim.cmd(":silent !black --preview -q " .. fileName)
        vim.cmd(":silent !isort --profile black --float-to-top -q " .. fileName)
        vim.cmd(":silent !docformatter --in-place --black " .. fileName)
    end,
    group = autocmd_group,
})

-- LSPs
require("lspconfig").htmx.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "php" },
})

local util = require("lspconfig.util")

require("lspconfig").gdscript.setup({
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
