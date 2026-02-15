local set = vim.keymap.set
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
