-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

local sessionizer = require("sessionizer")

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- smart-splits{{{

local function isViProcess(pane)
    -- get_foreground_process_name On Linux, macOS and Windows,
    -- the process can be queried to determine this path. Other operating systems
    -- (notably, FreeBSD and other unix systems) are not currently supported
    return pane:get_foreground_process_name():find('n?vim') ~= nil or pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
        -- This should match the keybinds you set in Neovim.
            act.SendKey({ key = vim_direction, mods = 'ALT' }),
            pane
        )
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)

-- }}}

-- smart-plits {{{
-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
    -- this is set by the plugin, and unset on ExitPre in Neovim
    return pane:get_user_vars().IS_NVIM == 'true'
end

-- if you *ARE* lazy-loading smart-splits.nvim (not recommended)
-- you have to use this instead, but note that this will not work
-- in all cases (e.g. over an SSH connection). Also note that
-- `pane:get_foreground_process_name()` can have high and highly variable
-- latency, so the other implementation of `is_vim()` will be more
-- performant as well.
local function is_vim(pane)
    -- This gsub is equivalent to POSIX basename(3)
    -- Given "/foo/bar" returns "bar"
    -- Given "c:\\foo\\bar" returns "bar"
    local process_name = string.gsub(pane:get_foreground_process_name(), '(.*[/\\])(.*)', '%2')
    return process_name == 'nvim' or process_name == 'vim'
end

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == 'resize' and 'ALT' or 'CTRL|SHIFT',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                -- pass the keys through to vim/nvim
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == 'resize' and 'ALT' or 'CTRL|SHIFT' },
                }, pane)
            else
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end
--}}}

config.keys = { -- {{{
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
    -- resize panes
    split_nav('resize', 'h'),
    split_nav('resize', 'j'),
    split_nav('resize', 'k'),
    split_nav('resize', 'l'),
    { key = "f", mods = "CTRL", action = wezterm.action_callback(sessionizer.toggle) },
    {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '-',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = "c",
        mods = "LEADER",
        action = act.SpawnTab("CurrentPaneDomain")
    },
    {
        key = 'a',
        mods = 'LEADER|CTRL',
        action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    -- Switch between tabs
    {
        key = 'p',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = "\r",
        mods = "LEADER",
        action = wezterm.action.ActivateCopyMode,
    },
    {
        key = "\r",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateCopyMode,
    }
} --}}}


-- This is where you actually apply your config choices
 
-- For example, changing the color scheme:
config.font = wezterm.font {
  family = 'JetBrains Mono',
  harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
  weight = "Regular"
}
config.font_size = 11

config.freetype_load_flags = 'NO_HINTING'
config.freetype_load_target = 'Light'
-- config.freetype_render_target = 'HorizontalLcd'
-- config.front_end = "WebGpu"


config.unix_domains = {
    { name = 'unix' },
}

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

    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },

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


-- This causes `wezterm` to act as though it was started as
-- `wezterm connect unix` by default, connecting to the unix
-- domain on startup.
-- If you prefer to connect manually, leave out this line.

config.default_gui_startup_args = { 'connect', 'unix' }


return config
