local gears = require("gears")


local awful = require("awful")

local wallpaper_dir = "/home/mirelois/wallpapers/"

local wallpapers, l = {}, 0

for file in io.popen('ls ' .. wallpaper_dir):lines() do
    l = l + 1
    wallpapers[l] = file
end

local random_index = math.random(1, l)

local get_random_wallpaper = function()

    local chosen_wallpaper = wallpaper_dir .. wallpapers[random_index]

    return chosen_wallpaper
end

return {
    get_random_wallpaper = get_random_wallpaper
}
