vim.g.mapleader = ' '
vim.g.localleader = '\\'

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

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
    },
})

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
    vim.opt.undodir = os.genenv("HOME") .. "/.vim/undodir"
end
vim.opt.undofile   = true
vim.opt.updatetime = 50
vim.opt.isfname:append("@-@")
vim.g.nofsync = true

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
