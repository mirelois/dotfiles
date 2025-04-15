---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources   = require("beautiful.xresources")
local dpi          = xresources.apply_dpi
local gears        = require('gears')

local gfs          = require("gears.filesystem")
local themes_path  = gfs.get_themes_dir()

local theme        = {

    maximized_honor_padding              = true,
    fullscreen_hide_border               = true,
    maximized_hide_border                = true,
    enable_spawn_cursor                  = false,
    gap_single_client                    = false,

    useless_gap                          = 4,
    border_width                         = 5,
    border_normal                        = "#242424",
    border_focus                         = '#957FB8',
    border_marked                        = "#FFFFFF",

    bar_bg                               = "#121212",

    taglist_fg_focus                     = "#DFDFDF",
    taglist_fg_occupied                  = "#DFDFDF",
    taglist_fg_empty                     = "#938AA9",
    taglist_font                         = "FontAwesome 12",
    taglist_underline_color              = "#938AA9",
    taglist_underline_thicknes           = 3,
    taglist_mouse_hover_background_color = "#212121",
    taglist_bar_width                    = 370,
    taglist_workspace_padding            = 11,

    bar_top_gap                          = 8,
    bar_horizontal_gap                   = 16,
    bar_height                           = 35,

    clock_width                          = 90,
    clock_font                           = "Ubunto 13",
    clock_fg                             = "#7FB4CA",

    utilities_width                      = 270,

    calendar_width                       = 200,
    calendar_height                      = 200,
    calendar_bg                          = "#121212",
    calendar_fg_focus                    = "#98BB6C",
    calendar_bg_focus                    = "#121212",
    calendar_fg_header                   = "#957fb8",
    calendar_fg_weekday                  = '#7788af',
    calendar_fg_weekend                  = '#DCDCDC',
    calendar_fg_day                      = '#ABABAB',

    battery_fg                           = "#7FB4CA",

    volume_fg                            = "#98BB6C",
    radial_border_color                  = "#343434",
    radial_border_width                  = 3,

    vpn_fg_connected                     = "#7E9CD8",
    vpn_fg                               = "#717c7c",

    mic_fg                               = "#7E9CD8",

    network_fg                           = "#E46876",

    notification_bg                      = "#121212",
    notification_fg                      = "#DCDCDC",
    notification_border_width            = 0,
    notification_max_width               = 350

}



return theme
