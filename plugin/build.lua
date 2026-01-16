local proj_conf = require("custom.proj_conf")

local function open_build_win()
    local windows = vim.api.nvim_tabpage_list_wins(0)

    local build_win = 0
    local current_win = vim.api.nvim_tabpage_get_win(0)

    if #windows == 1 then
        vim.cmd.new()
        vim.cmd.wincmd("H")
        build_win = vim.api.nvim_tabpage_get_win(0)
        vim.api.nvim_tabpage_set_win(0, current_win)
    else
        local largest_area = 0
        for _, val in ipairs(windows) do
            if val ~= current_win then
                local w = vim.api.nvim_win_get_width(val)
                local h = vim.api.nvim_win_get_height(val)
                local a = w * h
                if largest_area < a then
                    largest_area = a
                    build_win = val
                end
            end
        end
    end

    local build_cmd = proj_conf:get_opt("build_cmd")

    local build_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(build_win, build_buf)
    vim.api.nvim_buf_call(build_buf, function()
        vim.cmd("terminal " .. build_cmd)
    end)
end

local function edit_build_cmd()
    local build_cmd = proj_conf:get_opt("build_cmd")
    vim.ui.input({
        prompt = "Enter new build cmd (previous cmd: `" .. build_cmd .. "`): ",
    }, function(input)
        proj_conf:set_opt("build_cmd", input)
    end)
end

vim.keymap.set("n", "<leader>b", open_build_win, { desc = "Build" })
vim.keymap.set("n", "<leader>B", edit_build_cmd, { desc = "Edit build cmd" })
