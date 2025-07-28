local awful = require("awful")
local beautiful = require('beautiful')

function setup(clientkeys, clientbuttons)
    -- Rules to apply to new clients (through the "manage" signal).
    awful.rules.rules = {
        -- All clients will match this rule.
        {
            rule = {},
            properties = {
                maximized = false,
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap + awful.placement.no_offscreen
            }
        },
        {
            rule = { 
                class = "Firefox" 
            },
            properties = {
                tag = screen[1].tags[5],
                switch_to_tags = true
            }
        },
        {
            rule = { 
                class = "Youtube" 
            },
            properties = {
                tag = screen[1].tags[6],
                switch_to_tags = true
            }
        },
        {
            rule = { 
                class = "discord" 
            },
            properties = {
                tag = screen[1].tags[7],
                switch_to_tags = false
            }
        },
        {
            rule_any = {
                class = {'Evince', 'Zathura', 'Shotwell', 'sioyek', 'matplotlib'}
            },
            properties = {
                tag = screen[1].tags[3],
                switch_to_tags = true
            }
        },
        {
            rule_any = {
                class = {
                    'Gnome-calculator', 'Float', 'Xmessage', 'Gnome-control-center', 'Zathura'
                }
            },
            properties = {
                floating = true,
            }
        },
    }
end

return {
    setup = setup
}
