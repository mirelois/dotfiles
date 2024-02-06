vim.g.mapleader = ' '

-- I am still working on a better experience for configuring kitty-scrollback.nvim, but this works for now
require('kitty-scrollback').setup({
    global = function()
        return {
            status_window = {
                icons = {
                    nvim = '',
                },
            },
        }
    end,
})
