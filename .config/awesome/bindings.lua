local awful = require("awful")
local gears = require("gears")

local terminal = "kitty"
local modkey = "Mod4"

local rofi =
[[ rofi -no-lazy-grab -show drun -modi run,drun,window -theme /home/utilizador/.config/rofi/launcher/style -drun-icon-theme \"candy-icons\" ]]

local eww_window =
[[eww open-many --no-daemonize weather_side time_side smol_calendar player_side sys_side sliders_side]]


--{{{ Window bindings
local keys = gears.table.join(
    awful.key(
        { modkey }, ",",
        function()
            local screen = awful.screen.focused()
            awful.layout.inc(1, screen)
            local tag_name = awful.layout.get().name
            awful.spawn("notify-send " .. tag_name)
        end,
        { description = "cycle layout" }
    ),
    awful.key(
        { modkey, "Shift" }, ",",
        function()
            local screen = awful.screen.focused()
            awful.layout.inc(-1, screen)
            local tag_name = awful.layout.get().name
            awful.spawn("notify-send " .. tag_name)
        end,
        { description = "cycle layout" }
    ),
    awful.key(
        { modkey }, "Tab",
        awful.tag.history.restore,
        { description = "go back", group = "tag" }
    ),
    awful.key(
        { modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        { description = "move focus to the left", group = "client" }
    ),
    awful.key(
        { modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        { description = "move focus to the down", group = "client" }
    ),
    awful.key(
        { modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        { description = "move focus to the up", group = "client" }
    ),
    awful.key(
        { modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        { description = "move focus to the right", group = "client" }
    ),
    awful.key(
        { modkey, "Shift" }, "h",
        function() awful.client.swap.bydirection("left") end,
        { description = "move swap to the left", group = "client" }
    ),
    awful.key(
        { modkey, "Shift" }, "j",
        function() awful.client.swap.bydirection("down") end,
        { description = "move swap to the down", group = "client" }
    ),
    awful.key(
        { modkey, "Shift" }, "k",
        function() awful.client.swap.bydirection("up") end,
        { description = "move swap to the up", group = "client" }
    ),
    awful.key(
        { modkey, "Shift" }, "l",
        function() awful.client.swap.bydirection("right") end,
        { description = "move focus to the right", group = "client" }
    ),
    awful.key(
        { modkey, "Control" }, "j",
        function() awful.screen.focus_bydirection("down") end,
        { description = "move focus to screen up", group = "screen" }
    ),
    awful.key(
        { modkey, "Control" }, "k",
        function() awful.screen.focus_bydirection("up") end,
        { description = "move focus to screen down", group = "screen" }
    ),
    awful.key(
        { modkey, "Control" }, "l",
        function() awful.screen.focus_bydirection("right") end,
        { description = "move focus to screen right", group = "screen" }
    ),
    awful.key(
        { modkey, "Control" }, "h",
        function() awful.screen.focus_bydirection("left") end,
        { description = "move focus to screen left", group = "screen" }
    )
)
--}}}

--{{{ clientkeys
local myclientkeys = gears.table.join(
    awful.key(
        { modkey, "Control", "Shift" }, "j",
        function(c) 
            local s = awful.screen.focused():get_next_in_direction("down")
            c:move_to_screen(s)
            -- awful.screen.focus_bydirection("down") 
        end,
        { description = "move focus to screen up", group = "screen" }
    ),
    awful.key(
        { modkey, "Control", "Shift" }, "k",
        function(c) 
            local s = awful.screen.focused():get_next_in_direction("up")
            c:move_to_screen(s)
            -- awful.screen.focus_bydirection("down") 
        end,
        { description = "move focus to screen down", group = "screen" }
    ),
    awful.key(
        { modkey, "Control", "Shift" }, "h",
        function(c) 
            local s = awful.screen.focused():get_next_in_direction("left")
            c:move_to_screen(s)
            -- awful.screen.focus_bydirection("down") 
        end,
        { description = "move focus to screen up", group = "screen" }
    ),
    awful.key(
        { modkey, "Control", "Shift" }, "l",
        function(c) 
            local s = awful.screen.focused():get_next_in_direction("right")
            c:move_to_screen(s)
            -- awful.screen.focus_bydirection("down") 
        end,
        { description = "move client to screen", group = "screen" }
    ),
    awful.key(
        {}, "F11",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),
    awful.key(
        { modkey }, "w",
        function(c) c:kill() end,
        { description = "close", group = "client" }
    ),
    awful.key(
        { modkey }, "t",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key(
        { modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }
    )
)
--}}}

--{{{spawn stuff
keys = gears.table.join(keys,

    --Eww
    awful.key(
        { modkey, }, "p",
        function() awful.spawn(eww_window) end,
        { description = "spawn eww window", group = "tag" }
    ),
    awful.key(
        { modkey, }, "Escape",
        function() awful.spawn("eww close-all") end,
        { description = "Close eww", group = "tag" }
    ),
    --

    awful.key(
        { modkey }, "c",
        function() awful.spawn("gnome-calculator") end,
        { description = "lauch discord", group = "tag" }
    ),
    awful.key(
        { modkey }, "d",
        function() awful.spawn("discord") end,
        { description = "lauch discord", group = "tag" }
    ),
    awful.key(
        { modkey }, "b",
        function() awful.spawn([[firefox --class="Firefox"]]) end,
        { description = "lauch firefox", group = "tag" }
    ),
    awful.key(
        { modkey }, "y",
        function()
            awful.spawn(
                [[firefox --no-remote -P youtube --class "Youtube" https://www.youtube.com/]]
            )
        end,
        { description = "lauch discord", group = "tag" }
    ),

    awful.key(
        {}, "Print",
        function()
            awful.spawn("screenshot")
        end,
        { description = "lauch discord", group = "tag" }
    ),
    awful.key(
        { "Shift" }, "Print",
        function()
            awful.spawn(
                [[gnome-screenshot -wi]]
            )
        end,
        { description = "lauch discord", group = "tag" }
    ),

    awful.key(
        {}, "XF86MonBrightnessUp",
        function()
            awful.spawn("brightnessctl s +10%")
        end),

    awful.key(
        {}, "XF86MonBrightnessDown",
        function()
            awful.spawn("brightnessctl s 10-%")
        end),

    awful.key(
        {}, "XF86AudioLowerVolume",
        function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        end),

    awful.key(
        {}, "XF86AudioRaiseVolume",
        function()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end),

    awful.key(
        {}, "XF86AudioMute",
        function()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        end),

    awful.key(
        {}, "XF86AudioPlay",
        function()
            awful.spawn("playerctl play-pause")
        end),

    awful.key(
        {}, "XF86AudioPrev",
        function()
            awful.spawn("playerctl previous")
        end),

    awful.key(
        {}, "XF86AudioNext",
        function()
            awful.spawn("playerctl next")
        end),



    awful.key(
        { modkey, }, "r",
        function() awful.spawn(rofi) end,
        { description = "Spawn program launcher", group = "tag" }
    ),

    -- Standard program
    awful.key(
        { modkey, }, "Return",
        function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }
    ),
    awful.key(
        { modkey, "Control" }, "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),
    awful.key(
        { modkey }, "q",
        function() awful.spawn([[/home/utilizador/.config/eww/scripts/shutdown.sh]]) end,
        { description = "quit awesome", group = "awesome" }
    )
)
--}}}

--{{{ tag bindings
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i = 1, 9 do
    keys = gears.table.join(keys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end
--}}}

--{{{ clientbuttons
local myclientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)
-- }}}

root.keys(keys)

return {
    clientbuttons = myclientbuttons,
    clientkeys = myclientkeys,
}
