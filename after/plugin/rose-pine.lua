function Color(style)
    style = style or 'rose-pine'
    vim.cmd.colorscheme(style)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Color()
Color('catppuccin-mocha')
