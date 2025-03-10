vim.o.nu = true
vim.o.rnu = true

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
vim.opt.inccommand = "split"

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.guicursor = ""

vim.opt.mouse = "nv"

-- Don't sort .c and .h files seperately.
-- vim.g.netrw_sort_sequence = "[\\/]$,\\<core\\%(\\.\\d\\+\\)\\=\\>,\\~\\=\\*$,*,\\.o$,\\.obj$,\\.info$,\\.swp$,\\.bak$,\\~$"
