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

vim.g.vimtex_view_method = 'sioyek'

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

-- [[ Configure Which-Key ]]

require("which-key").add({
    { "<leader>c", group = "[C]ode" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>h", group = "Git [H]unk" },
    { "<leader>g", group = "[G]it" },
    { "<leader>a", group = "[A]lign", mode = "v" },
});

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

-- [[ Configure Harpoon 2 ]]

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

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

-- [[ Configure Align ]]

local align = require("align")

vim.keymap.set("x", "<leader>aa", function() align.align_to_char({ preview = false, length = 1 }) end, { desc = "Align to character" })
vim.keymap.set("x", "<leader>ap", function() align.align_to_char({ preview = true, length = 2 }) end, { desc = "Align to character (with Preview)" })
vim.keymap.set("x", "<leader>as", function() align.align_to_string({ preview = true, regex = false }) end, { desc = "Align to string" })
