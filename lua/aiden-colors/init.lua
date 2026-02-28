local M = {
    aiden_colors = {
        bg         = "#000000",
        fg         = "#c7d0eb",
        gray       = "#6c7086",
        dark_gray  = "#16171c",
        light_gray = "#878ba1",
        highlight  = "#332e36",
        purple     = "#cf8feb",
        green      = "#a6e3a1",
        green      = "#88d19f",
        dark_green = "#295236",
        blue       = "#7baee0",
        dark_blue  = "#294663",
        light_blue = "#a3a8d6",
        orange     = "#d4905d",
        yellow     = "#e0bb7b",
        red        = "#f08a86",
        dark_red   = "#7a3735",
    },
    aiden2_colors = {
        bg          = "#0a0f0e",
        fg          = "#969e9d",
        highlight   = "#23302e",
        comment     = "#576361",
        string      = "#88d19f",
        theme       = "#236152",
        theme1      = "#8BC6B8",
        diff_add    = "#295236",
        diff_change = "#294663",
        diff_delete = "#7a3735",
    },
}

local colors = M.colors

function M.apply_colors(color_name, color_map)
    vim.cmd("hi clear")

    vim.o.background  = "dark";
    vim.g.colors_name = color_name;

    local set = vim.api.nvim_set_hl

    -- [ Gui ]
    set(0, "Normal",      color_map.normal)
    set(0, "Visual",      color_map.visual)
    set(0, "ColorColumn", color_map.color_column)
    set(0, "StatusLine",  color_map.status_line)
    set(0, "Added",       color_map.added)
    set(0, "Changed",     color_map.changed)
    set(0, "Removed",     color_map.removed)
    set(0, "DiffAdd",     color_map.diff_add)
    set(0, "DiffChange",  color_map.diff_change)
    set(0, "DiffDelete",  color_map.diff_delete)
    set(0, "Directory",   color_map.directory)

    -- [ Syntax ]
    set(0, "Comment",             color_map.comment)
    set(0, "String",              color_map.string)
    set(0, "Statement",           color_map.statement)
    set(0, "Operator",            color_map.operator)
    set(0, "Delimiter",           color_map.delimiter)
    set(0, "@variable",           color_map.variable)
    set(0, "Function",            color_map.func)
    set(0, "Type",                color_map.type)
    set(0, "Constant",            color_map.constant)
    set(0, "@property",           color_map.property)
    set(0, "@variable.parameter", color_map.parameter)
    set(0, "Identifier",          color_map.identifier)
    set(0, "Special",             color_map.special)
    set(0, "Error",               color_map.error)
    set(0, "@variable.member",    { link = "@property" })
    set(0, "@variable.builtin",   { link = "@variable.parameter" })
    set(0, "@type.builtin",       { link = "Type" })
    set(0, "@function.builtin",   { link = "Function" })
    set(0, "@constructor",        { link = "Function" })
    set(0, "@constant.builtin",   { link = "Constant" })
end

function M.aiden()
    local colors = M.aiden_colors
    M.apply_colors("aiden", {
        -- [ Gui ] 
        normal       = { fg = colors.fg, bg = colors.bg },
        visual       = { bg = colors.highlight },
        color_column = { bg = colors.dark_gray },
        status_line  = { bg = colors.bg },
        added        = { fg = colors.green },
        changed      = { fg = colors.blue },
        removed      = { fg = colors.red },
        diff_add     = { bg = colors.dark_green },
        diff_change  = { bg = colors.dark_blue },
        diff_delete  = { bg = colors.dark_red },
        directory    = { fg = colors.green },
        -- [ Syntax ]
        comment    = { fg = colors.gray },
        string     = { fg = colors.green },
        statement  = { fg = colors.purple },
        operator   = { fg = colors.fg },
        delimiter  = { fg = colors.fg },
        variable   = { fg = colors.fg },
        func       = { fg = colors.blue },
        type       = { fg = colors.yellow },
        constant   = { fg = colors.orange },
        property   = { fg = colors.light_blue },
        parameter  = { fg = colors.red },
        identifier = { fg = colors.fg },
        special    = { fg = colors.fg },
        error      = { fg = colors.fg },
    })
end

function M.aiden2()
    local colors = M.aiden2_colors

    M.apply_colors("aiden2", {
        -- [ Gui ] 
        normal       = { fg = colors.fg, bg = colors.bg },
        visual       = { bg = colors.highlight          },
        color_column = { bg = colors.highlight          },
        status_line  = { bg = colors.bg                 },
        added        = { fg = colors.fg                 },
        changed      = { fg = colors.fg                 },
        removed      = { fg = colors.fg                 },
        diff_add     = { bg = colors.diff_add           },
        diff_change  = { bg = colors.diff_change        },
        diff_delete  = { bg = colors.diff_delete        },
        directory    = { fg = colors.theme              },
        -- [ Syntax ]
        comment    = { fg = colors.comment              },
        string     = { fg = colors.string               },
        statement  = { fg = colors.theme                },
        operator   = { fg = colors.fg                   },
        delimiter  = { fg = colors.fg                   },
        variable   = { fg = colors.fg                   },
        func       = { fg = colors.fg                   },
        type       = { fg = colors.theme1               },
        constant   = { fg = colors.fg                   },
        property   = { fg = colors.fg                   },
        parameter  = { fg = colors.fg                   },
        identifier = { fg = colors.fg                   },
        special    = { fg = colors.fg                   },
        error      = { fg = colors.fg                   },
    })
end

return M
