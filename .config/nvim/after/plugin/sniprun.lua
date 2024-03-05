require 'sniprun'.setup({

    --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
    --# to filter only sucessful runs (or errored-out runs respectively)
    display = {
        -- "Classic", --# display results in the command-line  area
        -- "VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)

        -- "VirtualText",             --# display results as virtual text
        "TempFloatingWindow", --# display results in a floating window
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
        SniprunVirtualTextOk  = { bg = "#54546D", fg = "#DCD7BA" },
        SniprunFloatingWinOk  = { fg = "#DDDDDD", },
        SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", },
        SniprunFloatingWinErr = { fg = "#881515", },
    },


    borders = 'single', --# display borders around floating windows
    --# possible values are 'none', 'single', 'double', or 'shadow'
})
