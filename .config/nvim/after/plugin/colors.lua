function Kanagawa(trans)
    -- Default options:
    require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,     -- do not set background color
        dimInactive = false,    -- dim inactive window `:h hl-NormalNC`
        terminalColors = false, -- define vim.g.terminal_color_{0,17}
        colors = {
            -- add/modify theme and palette colors
            palette = {},
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none"
                    }
                }
            }
        },

        overrides = function(colors)
            local theme = colors.theme
            return {

                Normal = {fg = "#DCDCDC"},

                Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                PmenuSbar = { bg = theme.ui.bg_m1 },
                PmenuThumb = { bg = theme.ui.bg_p2 },

                TelescopeTitle = { fg = theme.ui.special, bold = true },
                TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            }
        end,

        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = {
            -- map the value of 'background' option to a theme
            dark = "wave", -- try "dragon" !
            light = "lotus"
        },
    })

    -- if trans then
    --     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- end
    vim.cmd.colorscheme("kanagawa")
end

Kanagawa(true)
