local gears = require("gears")


local awful = require("awful")

local wallpaper_dir = "/home/utilizador/wallpapers/"

local wallpapers, l = {}, 0

for file in io.popen('ls ' .. wallpaper_dir):lines() do
    l = l + 1
    wallpapers[l] = file
end

local random_index = math.random(1, l)

local set_random_wallpaper = function(s)

    local chosen_wallpaper = wallpaper_dir .. wallpapers[random_index]

    gears.wallpaper.maximized(chosen_wallpaper, s)
end

return {
    set_random_wallpaper = set_random_wallpaper
}