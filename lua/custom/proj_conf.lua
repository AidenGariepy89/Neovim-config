local _proj_conf = {
    build_cmd = "build"
}

local function load_proj_conf()
    local f = io.open("nvim.lua", "r")
    if f ~= nil then
        io.close(f)
        local result = dofile("nvim.lua")
        if type(result) == "table" then
            for key, val in pairs(result) do
                _proj_conf[key] = val
            end
        end
    end
end

load_proj_conf()

---@class ProjConf
local ProjConf = {}

--- Retrieve the value for an option in the project config.
--- @param option string
--- @return any
function ProjConf:get_opt(option)
    return _proj_conf[option]
end

---@param option string
---@param value any
function ProjConf:set_opt(option, value)
    _proj_conf[option] = value
end

function ProjConf:reload()
    load_proj_conf()
end

local proj_conf = ProjConf

vim.keymap.set("n", "<leader>pr", function()
    proj_conf:reload()
end, { desc = "Reload project config" })

return proj_conf
