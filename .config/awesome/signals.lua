local awful = require("awful")
local beautiful = require('beautiful')
local gears = require('gears')

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

function setpadding()
    local s = awful.screen.focused()

    if s == screen.primary then
        if #s.tiled_clients >= 2 then
            s.padding = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0
            }
        else
            s.padding = {
                left = 0,
                right = 0,
                top = beautiful.bar_top_gap,
                bottom = 0
            }
        end
    end
end

-- Signal function to execute when a new client appears.
client.connect_signal("unmanage", function(c)
    setpadding()
end)

client.connect_signal("manage", function(c)
    setpadding()

    c.maximized = false
    c.fullscreen = false

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    setpadding()
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
    setpadding()
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    setpadding()
    c.border_color = beautiful.border_normal
end)

screen.connect_signal("arrange", function(s)

    local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
    -- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
    for _, c in pairs(s.clients) do
        if (max or only_one) and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)
