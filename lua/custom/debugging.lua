local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()
require("dap-go").setup()

require("nvim-dap-virtual-text").setup({})

if vim.fn.exepath("dlv") ~= "" then
    dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
            command = 'dlv',
            args = {'dap', '-l', '127.0.0.1:${port}'},
            -- add this if on windows, otherwise server won't open successfully
            -- detached = false
        }
    }

    dap.configurations.go = {
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}"
        },
        {
            type = "delve",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${file}"
        },
        -- works with go.mod packages and sub packages 
        {
            type = "delve",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}"
        },
        {
            type = "delve",
            name = "Debug project",
            request = "launch",
            program = "./main.go",
        },
    }
end


vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

vim.keymap.set("n", "<leader>?", function()
    require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F7>", dap.continue)
vim.keymap.set("n", "<F8>", dap.step_into)
vim.keymap.set("n", "<F9>", dap.step_over)
vim.keymap.set("n", "<F10>", dap.step_out)
vim.keymap.set("n", "<F11>", dap.step_back)
vim.keymap.set("n", "<F12>", dap.terminate)

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end
