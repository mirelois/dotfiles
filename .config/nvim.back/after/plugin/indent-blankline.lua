local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E46876" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E6C384" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7E9CD8" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FFA066" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98BB6C" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#957FB8" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#A3D4D5" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = {
    show_start = false,
    show_end = false,
    highlight = highlight
} }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
