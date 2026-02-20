vim.g.mapleader   = ' '
vim.g.localleader = '\\'

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- ///////
-- Options

-- [ Tabs & Spaces ]
-- NOTE: use `retab` to convert.
vim.opt.shiftwidth  = 4
vim.opt.softtabstop = 4
vim.opt.expandtab   = true

-- [ Visual Changes ]
vim.opt.nu            = true
vim.opt.rnu           = true
vim.opt.wrap          = false
vim.opt.breakindent   = true
vim.opt.hlsearch      = false
vim.opt.incsearch     = true
vim.opt.inccommand    = "split"
vim.opt.colorcolumn   = "80"
vim.opt.signcolumn    = "yes"
vim.opt.guicursor     = ""
vim.opt.mouse         = "nv"
vim.opt.scrolloff     = 8
vim.opt.termguicolors = true

-- [ Other ]
vim.opt.swapfile = false
vim.opt.backup   = false
if vim.uv.os_uname().sysname ~= "Windows_NT" then
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end
vim.opt.undofile   = true
vim.opt.updatetime = 50
vim.opt.isfname:append("@-@")
vim.g.nofsync = true

vim.cmd.colorscheme("aiden")

-- ///////////
-- Keymappings

local set = vim.keymap.set

-- [ Editing Helpers ]
set("v", "J", ":m '>+1<CR>gv=gv")         -- Move selected line down
set("v", "K", ":m '<-2<CR>gv=gv")         -- Move selected line up
set("n", "J", "mzJ`z")                    -- Append next line to current line
set("x", "<leader>p", [["_dP]])           -- Paste without yanking
set({ "n", "v" }, "<leader>y", [["+y]])   -- Yank to system clipboard
set("n", "<leader>Y", [["+Y]])            -- Yank to system clipboard
set({ "n", "v" }, "<leader>d", [["_d]])   -- Delete without yanking
set("n", "<C-j>", "<cmd>cnext<CR>zz")     -- Quickfix list next
set("n", "<C-k>", "<cmd>cprev<CR>zz")     -- Quickfix list prev
set("n", "<leader>j", "<cmd>lnext<CR>zz") -- Location list next
set("n", "<leader>k", "<cmd>lprev<CR>zz") -- Location list prev
set("n", "<leader>=", "<C-a>")            -- Increment number
set("n", "<leader>-", "<C-x>")            -- Decrement number
set("n", "<C-Space>", "<nop>")            -- Remove `<C-Space>` functionality
set("n", "Q", "<nop>")                    -- Remove `Q` functionality

-- [ Modified Existing Commands ]
set("n", "<C-u>", "<C-u>zz")     -- Center while scrolling
set("n", "<C-d>", "<C-d>zz")     -- Center while scrolling
set("n", "n", "nzzzv")           -- Center while `next`ing
set("n", "N", "Nzzzv")           -- Center while `next`ing
set("n", "<C-w>n", vim.cmd.vnew) -- Split horizontally by default

-- [ Extra capabilities ]
set("n", "<leader>x", "<cmd>!chmod +x %<CR>")      -- Make file executable
set("n", "<leader><leader>l", "<cmd>.lua<CR>")     -- Source current lua line
set("n", "<leader><leader>x", "<cmd>source %<CR>") -- Source current lua file
set("n", "<leader>i", "<cmd>Inspect<CR>")          -- Inspect

-- /////////////////////////
-- Plugin Setup and Keybinds

-- [ Undotree ]
set("n", "<leader>u", vim.cmd.UndotreeToggle) -- Open Undotree

-- [ Git Fugitive ]
set("n", "<leader>gs", vim.cmd.Git)
set("n", "<leader>gl", "<cmd>Git log --oneline<cr>")
set("n", "<leader>gf", "<cmd>Git fetch<cr>")
set("n", "gh", "<cmd>diffget //2<cr>", { desc = "Git diff select left" })
set("n", "gl", "<cmd>diffget //3<cr>", { desc = "Git diff select right" })

-- [ Harpooon ]
function harpoon_setup()
    local harpoon = require("harpoon")

    harpoon:setup()

    set("n", "<leader>a", function() harpoon:list():add() end)
    set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    set("n", "<C-h>", function() harpoon:list():select(1) end)
    set("n", "<C-t>", function() harpoon:list():select(2) end)
    set("n", "<C-n>", function() harpoon:list():select(3) end)
    set("n", "<C-s>", function() harpoon:list():select(4) end)

    set("n", "<C-S-P>", function() harpoon:list():prev() end)
    set("n", "<C-S-N>", function() harpoon:list():next() end)
end

-- [ Telescope ]
function telescope_setup()

    local builtin = require("telescope.builtin")

    set("n", "<leader>sf", builtin.find_files)  -- Search Files
    set("n", "<leader>sh", builtin.help_tags)   -- Search Help
    set("n", "<leader>sw", builtin.grep_string) -- Search Word
    set("n", "<leader>sg", builtin.live_grep)   -- Search Grep
    set("n", "<leader>sm", builtin.man_pages)   -- Search Manual
    set("n", "<leader>sb", builtin.buffers)     -- Search Buffers
    set("n", "<leader>sc", builtin.colorscheme) -- Search Colors
    set("n", "<leader>sch", builtin.highlights)  -- Search Highlights

end

-- [ Cmp ]
function cmp_setup()
    vim.opt.shortmess:append "c"

    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Insert }

    cmp.setup({
        sources = {
            { name = "path" },
            { name = "buffer" },
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
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        window = {
            completion = {
                border = "rounded",
                scrollbar = true,
            },
        },
    })
end

-- [ Align ]
function align_setup()
    local align = require("align")

    set("x", "<leader>aa", function() align.align_to_char({ preview = true, length = 1 }) end)      -- Align to character
    set("x", "<leader>ap", function() align.align_to_char({ preview = true, length = 2 }) end)      -- Align to character (with Preview)
    set("x", "<leader>as", function() align.align_to_string({ preview = true, regex = false }) end) -- Align to string
end

-- /////////
-- Compiling

local function is_quickfix_open()
    local result = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            result = true
            break
        end
    end
    return result
end

local function quickfix_error_count()
    local entries = vim.fn.getqflist()
    local errors = 0
    for _, entry in pairs(entries) do
        if entry.type ~= "" then
            errors = errors + 1
        end
    end
    return errors
end

if vim.uv.os_uname().sysname == "Windows_NT" then
    vim.cmd("set makeprg=nmake")
    vim.cmd("compiler msvc")
end

set("n", "<leader>b", function() -- Compile program
    vim.cmd("make")
    if quickfix_error_count() > 0 and not is_quickfix_open() then
        vim.cmd("copen")
    end
end)
set("n", "<leader>q", function() -- Toggle quickfix
    if is_quickfix_open() then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end)

-- ////////////////
-- Terminal Opening

local __term_info = nil

local function new_term()
    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
    vim.cmd.term()

    return vim.api.nvim_get_current_buf()
end

local function open_term()
    local term = __term_info

    if term == nil or vim.fn.bufexists(term) ~= 1 then
        term = new_term()
        __term_info = term
    end

    local windows = vim.fn.win_findbuf(term)

    if #windows > 0 then
        vim.api.nvim_set_current_win(windows[1])
        return
    end

    vim.cmd.new()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 10)
    vim.cmd.buffer(term)
end

set("n", "<leader>to", function() open_term() end) -- Open Terminal

-- ///////////////
-- Loading Plugins

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {

        -- ///////
        -- Plugins

        -- [ Colorscheme ]
        {
            "navarasu/onedark.nvim",
            priority = 1000,
            config = function()
            end,
        },

        -- [ Lualine ]
        {
            "nvim-lualine/lualine.nvim",
            commit = "a94fc68",
            opts = {
                sections = {
                    lualine_x = {
                        "encoding",
                        {
                            "fileformat",
                            symbols = {
                                unix = "lf",
                                dos = "crlf",
                                mac = "cr",
                            },
                        },
                        "filetype",
                    },
                },
                options = {
                    icons_enabled = true,
                    component_separators = '',
                    section_separators = '',
                    theme = 'aiden',
                },
            }
        },

        -- [ Undotree ]
        {
            "mbbill/undotree",
            tag = "rel_6.1",
        },

        -- [ Git Fugitive ]
        {
            "tpope/vim-fugitive",
        },

        -- [ Git Signs ]
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
                    vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk,
                    { buffer = bufnr, desc = "Preview git hunk" })

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
                    vim.keymap.set({ "n", "v" }, "[c", function()
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

        -- [ Comment ]
        {
            "numToStr/Comment.nvim",
            tag = "v0.8.0",
            opts = {},
        },

        -- [ Harpoon ]
        {
            "theprimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = harpoon_setup,
        },

        -- [ Telescope ]
        {
            "nvim-telescope/telescope.nvim",
            tag = "v0.2.1",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = telescope_setup,
        },

        -- [ Treesitter ]
        {
            "nvim-treesitter/nvim-treesitter",
            lazy = false,
            build = ":TSUpdate",
        },

        -- [ Cmp ]
        {
            "hrsh7th/nvim-cmp",
            lazy = false,
            priority = 100,
            dependencies = {
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
            },
            config = cmp_setup,
        },

        -- [ Align ]
        {
            "Vonr/align.nvim",
            commit = "bc5d57d", -- branch = "v2"
            lazy = true,
            init = align_setup,
        },

        -- [ Indent line ]
        {
            "lukas-reineke/indent-blankline.nvim",
            tag = "v3.9.0",
            main = "ibl",
            opts = {},
        },
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "c", "cpp", "python" },
    callback = function(ev)
        vim.treesitter.start()
    end,
})
