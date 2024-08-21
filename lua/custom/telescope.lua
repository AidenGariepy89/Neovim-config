local set = vim.keymap.set
local builtin = require("telescope.builtin")

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

set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
set("n", "<leader>/", function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in open buffer" })

set("n", "<C-p>", function()
    if is_git() then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
    end
end, { desc = "Search files (Git if available)" })

set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch [W]ord" })
set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch [G]rep" })
set("n", "<leader>sG", ":LiveGrepGitRoot<CR>", { desc = "[S]earch [G]rep Git Root" })
set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
