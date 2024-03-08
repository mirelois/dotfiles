require 'sniprun'.setup({

    --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
    --# to filter only sucessful runs (or errored-out runs respectively)
    display = {
        -- "Classic", --# display results in the command-line  area
        "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)

        -- "VirtualText",             --# display results as virtual text
        -- "TempFloatingWindow", --# display results in a floating window
        -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
        -- "Terminal",                --# display results in a vertical split
        -- "TerminalWithCode",        --# display results and code history in a vertical split
        -- "NvimNotify",              --# display with the nvim-notify plugin
        -- "Api"                      --# return output to a programming interface
    },

    --# You can use the same keys to customize whether a sniprun producing
    --# no output should display nothing or '(no output)'
    show_no_output = {
        "Classic",
        "TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
    },

    --# customize highlight groups (setting this overrides colorscheme)
    snipruncolors = {
        SniprunVirtualTextOk  = { bg = "#00000000", fg = "#727169" },
    },


    borders = 'none', --# display borders around floating windows
    --# possible values are 'none', 'single', 'double', or 'shadow'
})

vim.api.nvim_set_keymap('v', '<leader>r', ':SnipRun<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>SnipRunOperator', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>rr', ':SnipRun<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>rx', ':SnipClose<CR>', {silent = true})

