local awful = require('awful')
local gears = require('gears')

local beautiful = require('beautiful')

local main_screen_tags = { "", "", "󰈙", "", "", "", "", "", "" }

local get_random_wallpaper = require("wallpaper").get_random_wallpaper

awful.layout.layouts = {
    awful.layout.suit.tile.right,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
}

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local wallpaper = get_random_wallpaper()

awful.screen.connect_for_each_screen(function(s)

    if s == screen.primary then
        awful.tag(main_screen_tags, s, awful.layout.layouts[1])
    else
        awful.tag({tostring(s.index)}, s, awful.layout.layouts[1])
    end
    -- Each screen has its own tag table.
    gears.wallpaper.maximized(wallpaper, s)

end)

screen.connect_signal("added", function(s)
    gears.wallpaper.maximized(wallpaper, s)
end)

