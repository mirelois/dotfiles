local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}


return {
    {
        "rebelot/kanagawa.nvim",

        lazy = false,

        priority = 10000,

        opts = {
            compile = false,   -- enable compiling the colorscheme
            undercurl = false, -- enable undercurls
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
                local palette = colors.palette
                return {

                    Normal = { fg = "#DCDCDC" },
                    Visual = { bg = theme.ui.bg_p2 },
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },

                    RenderMarkdownCode = { fg = "NONE", bg = theme.ui.bg_dim },

                    RenderMarkdownH1Bg = { fg = palette.surimiOrange },
                    RenderMarkdownH2Bg = { fg = palette.springGreen },
                    RenderMarkdownH3Bg = { fg = palette.sakuraPink },
                    RenderMarkdownH4Bg = { fg = palette.springViolet1 },
                    RenderMarkdownH5Bg = { fg = palette.springBlue },
                    RenderMarkdownH6Bg = { fg = palette.autumnRed },

                    RenderMarkdownBullet = { fg = palette.oniViolet },

                    -- RenderMarkdownCode = { fg = "00000000",  bg = "NONE"},

                    RenderMarkdownTableHead = { fg = palette.autumnGreen },
                    RenderMarkdownTableRow = { fg = palette.autumnGreen },

                }
            end,

            theme = "wave", -- Load "wave" theme when 'background' option is not set
            background = {
                -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus"
            },
        },

    },

    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        dependencies = {
            "HiPhish/rainbow-delimiters.nvim"
        },
        init = function()
            vim.g.rainbow_delimiters = { highlight = highlight }
        end,
        config = function()
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
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
            require("ibl").setup({
                scope = {
                    show_start = false,
                    show_end = false,
                    highlight = highlight
                }
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function()
            local colors = {
                blue   = '#80a0ff',
                cyan   = '#79dac8',
                black  = '#080808',
                white  = '#c6c6c6',
                red    = '#ff5189',
                violet = '#d183e8',
                grey   = '#303030',
            }

            local bubbles_theme = {
                normal = {
                    a = { fg = colors.black, bg = colors.violet },
                    b = { fg = colors.white, bg = colors.grey },
                    c = { fg = colors.white, bg = "none" },
                },
                insert = { a = { fg = colors.black, bg = colors.blue } },
                visual = { a = { fg = colors.black, bg = colors.cyan } },
                replace = { a = { fg = colors.black, bg = colors.red } },
                inactive = {
                    a = { fg = colors.white, bg = colors.black },
                    b = { fg = colors.white, bg = colors.black },
                    c = { fg = colors.white, bg = colors.black },
                },
            }

            return {
                options = {
                    icons_enabled = true,
                    theme = bubbles_theme,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}

            }
        end
    },
}
