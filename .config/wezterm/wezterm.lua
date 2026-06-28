-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

local w = require('wezterm')

config.keys = {
    { key = "h", mods = 'CTRL|SHIFT', action = act.SendString '\x1b[72;6u' },
    { key = "j", mods = 'CTRL|SHIFT', action = act.SendString '\x1b[74;6u' },
    { key = "k", mods = 'CTRL|SHIFT', action = act.SendString "\x1b[75;6u" },
    { key = "l", mods = 'CTRL|SHIFT', action = act.SendString "\x1b[76;6u" },
    { key = "n", mods = 'CTRL|SHIFT', action = act.SendString "\x1b[110;6u" },
    { key = "p", mods = 'CTRL|SHIFT', action = act.SendString "\x1b[112;6u" },
    { key = "Enter", mods = 'SHIFT', action = act.SendString "\x1b[13;2u" },
    { key = "Enter", mods = 'CTRL', action = act.SendString "\x1b[13;5u" },
}


-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.font = wezterm.font {
--     family = 'Monocraft',
--     -- harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
--     weight = "Regular"
-- }



config.font = wezterm.font {
    family = 'Monocraft',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
    weight = "Regular"
}

config.font_size = 10

config.freetype_load_flags = 'NO_HINTING'
config.freetype_load_target = 'Light'
-- config.freetype_render_target = 'HorizontalLcd'
-- config.front_end = "WebGpu"


config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.window_close_confirmation = "NeverPrompt"

config.tab_max_width = 60

config.force_reverse_video_cursor = true

config.colors = { --{{{
    foreground = "#DCDCDC",
    background = "#000000",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = {
        "#090618",
        "#c34043",
        "#76946a",
        "#c0a36e",
        "#7e9cd8",
        "#957fb8",
        "#6a9589",
        "#c8c093",
    },
    brights = {
        "#727169",
        "#e82424",
        "#98bb6c",
        "#e6c384",
        "#7fb4ca",
        "#938aa9",
        "#7aa89f",
        "#dcd7ba",
    },
    indexed = { [16] = "#000000", [17] = "#ff5d62" },

    tab_bar = {
        -- The color of the strip that goes along the top of the window
        -- (does not apply when fancy tab bar is in use)
        background = 'rgba(0,0,0,0)',

        -- The active tab is the one that has focus in the window
        active_tab = {
            -- The color of the background area for the tab
            bg_color = '#1F1F28',
            -- The color of the text for the tab
            fg_color = '#C8C093',

            -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
            -- label shown for this tab.
            -- The default is "Normal"
            intensity = 'Bold',

            -- Specify whether you want "None", "Single" or "Double" underline for
            -- label shown for this tab.
            -- The default is "None"
            underline = 'None',

            -- Specify whether you want the text to be italic (true) or not (false)
            -- for this tab.  The default is false.
            italic = false,

            -- Specify whether you want the text to be rendered with strikethrough (true)
            -- or not for this tab.  The default is false.
            strikethrough = false,
        },

        -- Inactive tabs are the tabs that do not have focus
        inactive_tab = {
            bg_color = '#1F1F28',
            fg_color = '#727169',

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over inactive tabs
        inactive_tab_hover = {
            bg_color = '#212121',
            fg_color = '#DFDFDF',
            italic = false,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `inactive_tab_hover`.
        },

        -- The new tab button that let you create new tabs
        new_tab = {
            bg_color = '#141414',
            fg_color = '#808080',

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab`.
        },

        -- You can configure some alternate styling when the mouse pointer
        -- moves over the new tab button
        new_tab_hover = {
            bg_color = '#212121',
            fg_color = '#909090',
            italic = true,

            -- The same options that were listed under the `active_tab` section above
            -- can also be used for `new_tab_hover`.
        },
    }
} --}}}

config.window_background_opacity = 0.75

-- title {{{
local function get_current_working_dir(tab)
    local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = '' }
    local HOME_DIR = string.format('file://%s', os.getenv('HOME'))

    return current_dir == HOME_DIR and '.'
        or string.gsub(current_dir.file_path, '(.*[/\\])(.*)', '%2')
end

-- Set tab title to the one that was set via `tab:set_title()`
-- or fall back to the current working directory as a title
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local index = tonumber(tab.tab_index) + 1
    local custom_title = tab.tab_title
    local title = get_current_working_dir(tab)

    if custom_title and #custom_title > 0 then
        title = custom_title
    end

    return string.format('  %s: %s  ', index, title)
end)

-- Set window title to the current working directory
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return get_current_working_dir(tab)
end)

-- }}}

config.inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
}

config.quick_select_patterns = {
    [[[^ ]+\.[^ ]*]]
}

-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.

-- config.default_gui_startup_args = { 'connect', 'unix' }


return config
