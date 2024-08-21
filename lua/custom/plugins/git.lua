return {
    {
        "tpope/vim-fugitive",
        config = function()
            local set = vim.keymap.set

            set("n", "<leader>gs", vim.cmd.Git)
            set("n", "<leader>gl", "<cmd>Git log --oneline<cr>")
            set("n", "<leader>gf", "<cmd>Git fetch<cr>")
            set("n", "gh", "<cmd>diffget //2<cr>", { desc = "Git diff select left" })
            set("n", "gl", "<cmd>diffget //3<cr>", { desc = "Git diff select right" })

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
                    set("n", "<leader>p", function()
                        vim.cmd.Git("push")
                    end, opts)
                    set("n", "<leader>P", function()
                        vim.cmd.Git("pull --rebase")
                    end, opts)
                    set("n", "<leader>t", ":Git push -u origin main", opts)
                end,
            })
        end,
    },


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
}
