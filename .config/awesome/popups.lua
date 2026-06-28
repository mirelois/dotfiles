local gears = require("gears")
local awful = require("awful")

local s = screen.primary

local text_prompt = awful.wibar {
    position = "top",
    screen = s,
    -- width = beautiful.utilities_width,
    -- height = beautiful.bar_height + beautiful.bar_top_gap,
    -- width = s.geometry.width - 2 * beautiful.bar_horizontal_gap,
    shape = gears.shape.rectangle,
    bg = "#000000",
}

text_prompt:setup {
    {
        widget = widget.prompt
    }
}

