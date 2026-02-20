local M = {
    colors = {
        bg         = "#000000",
        -- fg         = "#cdd6f4",
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
    }
}

local colors = M.colors

function M.aiden()
    vim.cmd("hi clear")

    vim.o.background  = "dark";
    vim.g.colors_name = "aiden";

    local set = vim.api.nvim_set_hl

    -- [ Gui ]
    set(0, "Normal",      { fg = colors.fg, bg = colors.bg })
    set(0, "Visual",      { bg = colors.highlight })
    set(0, "ColorColumn", { bg = colors.dark_gray })
    set(0, "StatusLine",  { bg = colors.bg })
    set(0, "Added",       { fg = colors.green })
    set(0, "Changed",     { fg = colors.blue })
    set(0, "Removed",     { fg = colors.red })
    set(0, "DiffAdd",     { bg = colors.dark_green })
    set(0, "DiffChange",  { bg = colors.dark_blue })
    set(0, "DiffDelete",  { bg = colors.dark_red })
    set(0, "Directory",   { fg = colors.green })

    -- [ Syntax ]
    set(0, "Comment",             { fg = colors.gray })
    set(0, "String",              { fg = colors.green })
    set(0, "Statement",           { fg = colors.purple })
    set(0, "Operator",            { fg = colors.fg })
    set(0, "Delimiter",           { fg = colors.fg })
    set(0, "@variable",           { fg = colors.fg })
    set(0, "Function",            { fg = colors.blue })
    set(0, "Type",                { fg = colors.yellow })
    set(0, "Constant",            { fg = colors.orange })
    set(0, "@property",           { fg = colors.light_blue })
    set(0, "@variable.parameter", { fg = colors.red })
    set(0, "Identifier",          { fg = colors.fg })
    set(0, "Special",             { fg = colors.fg })
    set(0, "Error",               { fg = colors.fg })
    set(0, "@variable.member",    { link = "@property" })
    set(0, "@variable.builtin",   { link = "@variable.parameter" })
    set(0, "@type.builtin",       { link = "Type" })
    set(0, "@function.builtin",   { link = "Function" })
    set(0, "@constructor",        { link = "Function" })
    set(0, "@constant.builtin",   { link = "Constant" })

end

function M.aiden_dim()
    vim.cmd("hi clear")

    vim.o.background  = "dark";
    vim.g.colors_name = "aiden-dim";

    local set = vim.api.nvim_set_hl

    -- [ Gui ]
    set(0, "Normal",      { fg = colors.fg, bg = colors.bg })
    set(0, "Visual",      { bg = colors.highlight })
    set(0, "ColorColumn", { bg = colors.dark_gray })
    set(0, "StatusLine",  { bg = colors.bg })
    set(0, "Added",       { fg = colors.green })
    set(0, "Changed",     { fg = colors.blue })
    set(0, "Removed",     { fg = colors.red })
    set(0, "DiffAdd",     { bg = colors.dark_green })
    set(0, "DiffChange",  { bg = colors.dark_blue })
    set(0, "DiffDelete",  { bg = colors.dark_red })
    set(0, "Directory",   { fg = colors.green })

    -- [ Syntax ]
    set(0, "Comment",             { fg = colors.gray })
    set(0, "String",              { fg = colors.green })
    set(0, "Statement",           { fg = colors.fg })
    set(0, "Operator",            { fg = colors.fg })
    set(0, "Delimiter",           { fg = colors.fg })
    set(0, "@variable",           { fg = colors.fg })
    set(0, "Function",            { fg = colors.fg })
    set(0, "Type",                { fg = colors.fg })
    set(0, "Constant",            { fg = colors.fg })
    set(0, "@property",           { fg = colors.fg })
    set(0, "@variable.parameter", { fg = colors.fg })
    set(0, "@variable.member",    { link = "@property" })
    set(0, "@type.builtin",       { link = "Type" })
    set(0, "Identifier",          { fg = colors.fg })
    set(0, "Special",             { fg = colors.fg })
    set(0, "Error",               { fg = colors.fg })

end

return M
