local set = vim.keymap.set

set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open explorer" })

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "J", "mzJ`z")
set("n", "<C-u>", "<C-u>zz")
set("n", "<C-d>", "<C-d>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("x", "<leader>p", [["_dP]], { desc = "[p]aste and don't yank" })
set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[y]ank to clipboard" })
set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank to clipboard" })
set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[d]elete and don't yank" })
set("n", "<C-Space>", "")
set("n", "q:", "") -- get rid of that pesky menu

set("n", "Q", "<nop>")
set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })

set("n", "<C-j>", "<cmd>cnext<CR>zz")
set("n", "<C-k>", "<cmd>cprev<CR>zz")
set("n", "<leader>j", "<cmd>lnext<CR>zz", { desc = "Locator list next" })
set("n", "<leader>k", "<cmd>lprev<CR>zz", { desc = "Locator list prev" })

set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

set("n", "<leader>=", "<C-a>", { desc = "Increment" })
set("n", "<leader>-", "<C-x>", { desc = "Decrement" })

set("n", "<leader><leader>l", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Run lua file" })
