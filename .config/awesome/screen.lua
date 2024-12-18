local awful = require('awful')
local gears = require('gears')

local beautiful = require('beautiful')

local main_screen_tags = { "", "", "󰈙", "", "", "", "", "", "" }

local bottom_screen_tags = { "󱧐" }

function get_tag_list()
    -- return table.insert(main_screen_tags, bottom_screen_tags[1])
    return gears.table.join(main_screen_tags, bottom_screen_tags)
end

local set_random_wallpaper = require("wallpaper").set_random_wallpaper

awful.layout.layouts = {
    awful.layout.suit.tile.right,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
}

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

awful.screen.connect_for_each_screen(function(s)
    set_random_wallpaper(s)

    if s.index == 1 then
        awful.tag(main_screen_tags, s, awful.layout.layouts[1])
    else
        awful.tag(bottom_screen_tags, s, awful.layout.layouts[1])
    end
    -- Each screen has its own tag table.
end)
