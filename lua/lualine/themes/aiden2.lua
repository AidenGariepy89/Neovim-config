local colors = require("aiden-colors").aiden2_colors

return {
    normal = {
        a = {bg = colors.theme1, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.bg, fg = colors.fg},
        c = {bg = colors.bg, fg = colors.fg}
    },
    insert = {
        a = {bg = colors.string, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.bg, fg = colors.fg},
        c = {bg = colors.bg, fg = colors.fg}
    },
    visual = {
        a = {bg = colors.theme, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.bg, fg = colors.fg},
        c = {bg = colors.bg, fg = colors.fg}
    },
    replace = {
        a = {bg = colors.diff_delete, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.bg, fg = colors.fg},
        c = {bg = colors.bg, fg = colors.fg}
    },
    command = {
        a = {bg = colors.diff_change, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.bg, fg = colors.fg},
        c = {bg = colors.bg, fg = colors.fg}
    },
    inactive = {
        a = {bg = colors.bg, fg = colors.highlight, gui = 'bold'},
        b = {bg = colors.bg, fg = colors.highlight},
        c = {bg = colors.bg, fg = colors.highlight}
    }
}
