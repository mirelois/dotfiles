function Rose_Pine(trans)
    vim.cmd.colorscheme("rose-pine")

    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

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
                NormalFloat = { bg = "none" },
                FloatBorder = { bg = "none" },
                -- Save an hlgroup with dark background and dimmed foreground
                -- so that you can use it where your still want darker windows.
                -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                -- Popular plugins that open floats will link to NormalFloat by default;
                -- set their background accordingly if you wish to keep them dark and borderless
                LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = {
            -- map the value of 'background' option to a theme
            dark = "wave", -- try "dragon" !
            light = "lotus"
        },
    })

    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
    vim.cmd.colorscheme("kanagawa")
end

function BOO(_theme, trans)
    require("boo-colorscheme").use({ theme = _theme })

    --themes--
    --sunset_cloud
    --radioactive_waste
    --forest_stream
    --crimson_moonlight

    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

function TokyoNight(_style, trans)
    require("tokyonight").setup({ style = _style })

    --styles--
    --storm
    --moon
    --night
    --day

    vim.cmd.colorscheme("tokyonight")

    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

function GruvBox(trans)
    vim.cmd.colorscheme("gruvbox")

    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

function Dracula(trans)
    vim.cmd.colorscheme("dracula")

    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

function NightFox(_style, trans)
    require('nightfox').setup({})
    vim.cmd.colorscheme(_style .. "fox")

    --themes--
    --dawn
    --night
    --tera
    --carbon
    --nord
    --dusk
    --day

    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end

function NotColorMyPencils()
    vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "black" })
end

function ColorMyPencils()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function Catppuccin(trans)
    local catppuccin = require("catppuccin")

    catppuccin.setup({
        -- latte, frappe, macchiato, mocha
        transparent_background = trans,
        flavour = "frappe"
    })
    --     integrations = {
    --         ts_rainbow = true,
    --     },
    --     color_overrides = {
    --         mocha = {
    --             text = "#F4CDE9",
    --             subtext1 = "#DEBAD4",
    --             subtext0 = "#C8A6BE",
    --             overlay2 = "#B293A8",
    --             overlay1 = "#9C7F92",
    --             overlay0 = "#866C7D",
    --             surface2 = "#6E6A86", -- coments
    --             surface1 = "#6E6A86", -- numerus
    --             surface0 = "#44313B", --barra

    --             base = "#352939",
    --             mantle = "#211924",
    --             crust = "#1a1016",
    --         },
    --     },
    -- })

    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin"
end

function TokyoGogh(style, trans)
    -- lua
    require('tokyogogh').setup {
        style = style, -- storm | night
        term_colors = true,
        -- Change code styles
        code_styles = {
            strings = { italic = false, bold = false },
            comments = { italic = true, bold = false },
            functions = { italic = false, bold = false },
            variables = { italic = false, bold = false },
        },
        diagnostics = {
            undercurl = true, -- use undercurl instead of underline
            background = false,
        },
        -- Customization
        colors = {},
        highlight = {},
    }
    vim.cmd([[colorscheme tokyogogh]])
    if trans then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
end


-- Catppuccin(true)
-- NightFox("dusk", true)
-- Dracula(true)
Kanagawa(true)
-- TokyoNight(true)
-- TokyoGogh('night', true)
