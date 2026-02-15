local colors = require("aiden-colors").colors

return {
    normal = {
        a = {bg = colors.blue, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.dark_gray, fg = colors.light_gray},
        c = {bg = colors.bg, fg = colors.fg}
    },
    insert = {
        a = {bg = colors.green, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.dark_gray, fg = colors.light_gray},
        c = {bg = colors.bg, fg = colors.fg}
    },
    visual = {
        a = {bg = colors.purple, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.dark_gray, fg = colors.light_gray},
        c = {bg = colors.bg, fg = colors.fg}
    },
    replace = {
        a = {bg = colors.red, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.dark_gray, fg = colors.light_gray},
        c = {bg = colors.bg, fg = colors.fg}
    },
    command = {
        a = {bg = colors.orange, fg = colors.bg, gui = 'bold'},
        b = {bg = colors.dark_gray, fg = colors.light_gray},
        c = {bg = colors.bg, fg = colors.fg}
    },
    inactive = {
        a = {bg = colors.dark_gray, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.dark_gray, fg = colors.gray},
        c = {bg = colors.dark_gray, fg = colors.gray}
    }
}
