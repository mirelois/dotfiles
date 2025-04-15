-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


-- {{{ workspaces
-- Create a textclock widget
local s = screen.primary

local s_width = s.geometry.width
local s_height = s.geometry.height

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    -- awful.button({ modkey }, 1, function(t)
    --     if client.focus then
    --         client.focus:move_to_tag(t)
    --     end
    -- end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

function set_underline(self, index)
    local focused = false

    for _, x in pairs(s.selected_tags) do
        if x.index == index then
            focused = true
            break
        end
    end
    if focused then
        self:get_children_by_id("margin")[1].color = beautiful.taglist_underline_color
    else
        self:get_children_by_id("margin")[1].color = beautiful.bar_bg
    end
end

-- Create a taglist widget
local taglist = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    buttons         = taglist_buttons,
    widget_template = {
        {
            {
                {
                    id = "text_role",
                    widget = wibox.widget.textbox,
                },
                id = "gaps",
                widget = wibox.container.margin,
                left = beautiful.taglist_workspace_padding,
                right = beautiful.taglist_workspace_padding,
            },
            id = "margin",
            widget = wibox.container.margin,
            bottom = beautiful.taglist_underline_thicknes,
            -- color = "#FFFFFF"
        },
        id = "background_role",
        shape = gears.shape.rectangle,
        widget = wibox.container.background,
        create_callback = function(self, c3, index, objects)
            set_underline(self, index)

            local hover_color = beautiful.taglist_mouse_hover_background_color

            self:connect_signal('mouse::enter', function()
                if self.bg ~= hover_color then
                    self.backup     = self.bg
                    self.has_backup = true
                end
                self.bg = hover_color
            end)
            self:connect_signal('mouse::leave', function()
                if self.has_backup then self.bg = self.backup end
            end)
        end,
        update_callback = function(self, c3, index, objects)
            set_underline(self, index)
        end
    }
}
-- }}}


-- clock {{{

-- calendar {{{


local styles   = {}

styles.month   = {
    padding      = 5,
    bg_color     = beautiful.calendar_bg,
    border_width = 0,
}
styles.focus   = {
    fg_color = beautiful.calendar_fg_focus,
    bg_color = beautiful.calendar_bg_focus,
    markup   = function(t) return '<b>' .. t .. '</b>' end,
    shape    = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 5)
    end
}
styles.header  = {
    fg_color = beautiful.calendar_fg_header,
    markup   = function(t) return '<b>' .. t .. '</b>' end,
}
styles.weekday = {
    fg_color = beautiful.calendar_fg_weekday,
    markup   = function(t) return '<b>' .. t .. '</b>' end,
}
local function decorate_cell(widget, flag, date)
    if flag == 'monthheader' and not styles.monthheader then
        flag = 'header'
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
    local weekday = tonumber(os.date('%w', os.time(d)))
    local default_fg = (weekday == 0 or weekday == 6) and beautiful.calendar_fg_weekend or beautiful.calendar_fg_day
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape              = props.shape,
        shape_border_width = props.border_width or 0,
        fg                 = props.fg_color or default_fg,
        bg                 = props.bg_color or beautiful.bar_bg,
        widget             = wibox.container.background
    }
    return ret
end

local cal = wibox.widget {
    date     = os.date('*t'),
    fn_embed = decorate_cell,
    widget   = wibox.widget.calendar.month
}


local calendar_bar = wibox({
    position = "top",
    screen   = s,
    ontop    = true,
    width    = beautiful.calendar_width,
    height   = beautiful.calendar_height,
    -- shape = gears.shape.roun,
    bg       = beautiful.bar_bg,
    fg       = beautiful.calendar_fg,
    x        = s_width - beautiful.calendar_width - beautiful.bar_horizontal_gap,
    y        = beautiful.bar_height + 2 * beautiful.bar_top_gap,
    visible  = false

})

calendar_bar:setup {
    layout = wibox.container.place,
    cal,
}

-- }}}

local clock_buttons = gears.table.join(
    awful.button({}, 1, function() calendar_bar.visible = not calendar_bar.visible end)
)

local clock = wibox.widget {
    format = "%H:%M",
    widget = wibox.widget.textclock,
    font = beautiful.clock_font,
    buttons = clock_buttons,
}

--}}}


-- utilities {{{

-- battery {{{
local update_battery_widget = function(widget, stdout, stderr, exitreason, exitcode)
    local status, charge_str, _ = string.match(stdout, '.+: ([%a%s]+), (%d?%d?%d)%%,?(.*)')

    local charge = tonumber(charge_str)

    local output

    if (status == "Not charging" and charge == 100) or (status == "Charging") then
        output = ""
    else
        if charge < 20 then
            output = ""
        elseif charge < 40 then
            output = ""
        elseif charge < 60 then
            output = ""
        elseif charge < 80 then
            output = ""
        else
            output = ""
        end
    end

    -- output = string.format([[%s  <span foreground="gray">󰇙</span>  %d%%]], output, charge_str)

    widget:set_text(output, charge_str)
end

local battery_widget = wibox.widget {
    {
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 9,
            {
                id = "icon",
                widget = wibox.widget.textbox,
                font = "Symbols Nerd Font 12",
                halign = "center",
                valign = "center",
            },
            {
                {
                    id = "sep",
                    widget = wibox.widget.textbox,
                    font = "Symbols Nerd Font 12",
                    halign = "center",
                    valign = "center",
                    markup = [[<span foreground="gray" size="xx-large"></span>]]
                },
                widget = wibox.container.place,
                content_fill_vertical = true
            },
            {
                id = "number",
                widget = wibox.widget.textbox,
                font = "Symbols Nerd Font 12",
                halign = "center",
                valign = "center",
            }
        },
        widget = wibox.container.place,
        -- forced_width = beautiful.bar_height * 3,
    },
    fg = beautiful.battery_fg,
    widget = wibox.container.background,
    set_text = function(self, icon, charge)
        self:get_children_by_id('icon')[1]:set_markup(icon)
        self:get_children_by_id('number')[1]:set_markup(charge .. "%")
    end,

}

-- }}}

-- volume {{{

local update_volume_widget = function(widget, stdout, stderr, exitreason, exitcode)
    -- \[(o\D\D?)\] - [on] or [off]
    local is_mute = string.match(stdout, "%[(o%D%D?)%]") == "off"

    -- (\d?\d?\d)\%)
    local volume_level = tonumber(string.match(stdout, "(%d?%d?%d)%%"))

    widget.value = volume_level

    if is_mute then
        widget:set_text("󰝟")
        return
    end

    -- characters not showing but are there
    if volume_level < 33 then
        widget:set_text("")
    elseif volume_level < 66 then
        widget:set_text("")
    else
        widget:set_text("")
    end
end

local volume_widget = wibox.widget {
    {
        {
            {
                id = "txt",
                halign = "center",
                valign = "center",
                widget = wibox.widget.textbox,
                font = "Symbols Nerd Font 12",
            },
            widget = wibox.container.background,
            fg = beautiful.volume_fg
        },
        widget = wibox.container.place
    },
    min_value = 0,
    max_value = 100,
    border_color = beautiful.radial_border_color,
    color = beautiful.volume_fg,
    border_width = beautiful.radial_border_width,
    widget = wibox.container.radialprogressbar,
    forced_height = beautiful.bar_height,
    forced_width = beautiful.bar_height,
    set_text = function(self, text)
        self:get_children_by_id('txt')[1]:set_text(text)
    end,
}

local update_volume_widget_callback = function(stdout, stderr, exitreason, exitcode)
    update_volume_widget(volume_widget, stdout, stderr, exitreason, exitcode)
end


volume_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.easy_async("amixer -D pulse sset Master toggle",
            update_volume_widget_callback
        )
    end),
    awful.button({}, 4, function()
        awful.spawn.easy_async("amixer -D pulse sset Master 5%+",
            update_volume_widget_callback
        )
    end),
    awful.button({}, 5, function()
        awful.spawn.easy_async("amixer -D pulse sset Master 5%-",
            update_volume_widget_callback
        )
    end)
))


-- }}}

-- mic {{{

local update_mic_widget = function(widget, stdout, stderr, exitreason, exitcode)
    -- \[(o\D\D?)\] - [on] or [off]
    local is_mute = string.match(stdout, "%[(o%D%D?)%]") == "off"

    -- (\d?\d?\d)\%)
    local mic_level = tonumber(string.match(stdout, "(%d?%d?%d)%%"))

    widget.value = mic_level

    if is_mute then
        widget:set_text("")
    else
        widget:set_text("")
    end
end

local mic_widget = wibox.widget {
    {
        {
            {
                id = "txt",
                halign = "center",
                valign = "center",
                widget = wibox.widget.textbox,
                font = "Symbols Nerd Font 12"
            },
            widget = wibox.container.background,
            fg = beautiful.mic_fg

        },
        widget = wibox.container.place
    },
    min_value = 0,
    max_value = 100,
    border_color = beautiful.radial_border_color,
    color = beautiful.mic_fg,
    border_width = beautiful.radial_border_width,
    widget = wibox.container.radialprogressbar,
    forced_height = beautiful.bar_height,
    forced_width = beautiful.bar_height,
    set_text = function(self, text)
        self:get_children_by_id('txt')[1]:set_text(text)
    end,
}

local update_mic_widget_callback = function(stdout, stderr, exitreason, exitcode)
    update_mic_widget(mic_widget, stdout, stderr, exitreason, exitcode)
end


mic_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.easy_async("amixer -D pulse sset Capture toggle",
            update_mic_widget_callback
        )
    end),
    awful.button({}, 4, function()
        awful.spawn.easy_async("amixer -D pulse sset Capture 5%+",
            update_mic_widget_callback
        )
    end),
    awful.button({}, 5, function()
        awful.spawn.easy_async("amixer -D pulse sset Capture 5%-",
            update_mic_widget_callback
        )
    end)
))


-- }}}

-- network {{{
local update_network_widget = function(widget, stdout, stderr, exitreason, exitcode)

    local is_not_connected = string.match(stdout, "Not connected")

    if is_not_connected ~= nil then
        widget:set_text("")
        return
    end

    local value = string.match(stdout, "signal:[ ]*(-?%d+)[ ]*dBm")

    local ratio = ((tonumber(value) + 110) * 10 / 7)

    if ratio < 20 then
        widget:set_text("󰤯")
    elseif ratio < 40 then
        widget:set_text("󰤟")
    elseif ratio < 60 then
        widget:set_text("󰤢")
    elseif ratio < 80 then
        widget:set_text("󰤥")
    else
        widget:set_text("󰤨")
    end
end

local network_widget = wibox.widget {
    {
        {
            id = "txt",
            text = "",
            widget = wibox.widget.textbox,
            font = "Symbols Nerd Font 15",
        },
        widget = wibox.container.place,
        -- forced_width = beautiful.bar_height,
    },
    widget = wibox.container.background,
    fg = beautiful.network_fg,
    set_text = function(self, text)
        self:get_children_by_id('txt')[1]:set_text(text)
    end,
}

-- }}}

-- vpn {{{

local update_vpn_widget = function(widget, stdout, stderr, exitreason, exitcode)
    -- \[(o\D\D?)\] - [on] or [off]
    local vpn_is_on = string.match(stdout, "Client connected") ~= nil

    if vpn_is_on then
        widget.fg = beautiful.vpn_fg_connected
    else
        widget.fg = beautiful.vpn_fg
    end
end

local vpn_widget = wibox.widget {
    {
        {
            text   = "󰖂",
            halign = "center",
            valign = "center",
            widget = wibox.widget.textbox,
            font   = "Symbols Nerd Font 15",
        },
        widget = wibox.container.place,
        -- forced_width = beautiful.bar_height/2,

    },
    fg = "#121212",
    widget = wibox.container.background,
}


vpn_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.easy_async_with_shell(
            "/home/mirelois/.config/polybar/scripts/vpn_toggle.sh",
            function()
                awful.spawn.easy_async_with_shell("openvpn3 sessions-list",
                    function(stdout, stderr, exitreason, exitcode)
                        update_vpn_widget(vpn_widget, stdout, stderr, exitreason, exitcode)
                    end
                )
            end
        )
    end)
))

--}}}

-- }}}


-- bar definition {{{
local main_bar = awful.wibar {
    position = "top",
    screen = s,
    -- width = beautiful.utilities_width,
    height = beautiful.bar_height + beautiful.bar_top_gap,
    width = s.geometry.width - 2 * beautiful.bar_horizontal_gap,
    shape = gears.shape.rectangle,
    bg = "#00000000",
}

main_bar:setup {
    {
        {
            {
                {
                    widget = wibox.container.place,
                    content_fill_vertical = true,
                    taglist,
                },
                widget = wibox.container.background,
                shape = gears.shape.rounded_bar,
                bg = beautiful.bar_bg,
                forced_width = beautiful.taglist_bar_width
            },
            widget = wibox.container.margin,
            -- left = beautiful.bar_horizontal_gap
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                {
                    {
                        layout = wibox.container.place,
                        {
                            layout = wibox.layout.fixed.horizontal,
                            vpn_widget,
                            network_widget,
                            mic_widget,
                            volume_widget,
                            battery_widget,
                            fill_space = true,
                            spacing = 15,
                        },
                    },
                    widget = wibox.container.background,
                    shape = gears.shape.rounded_bar,
                    bg = beautiful.bar_bg,
                    forced_width = beautiful.utilities_width
                },
                widget = wibox.container.margin,
                left = beautiful.bar_horizontal_gap,
                right = beautiful.bar_horizontal_gap
            },
            {
                {
                    {
                        layout = wibox.container.place,
                        clock,
                    },
                    widget = wibox.container.background,
                    shape = gears.shape.rounded_bar,
                    bg = beautiful.bar_bg,
                    fg = beautiful.clock_fg,
                    forced_width = beautiful.clock_width
                },
                widget = wibox.container.margin,
                left = beautiful.bar_horizontal_gap,
                -- right = beautiful.bar_horizontal_gap
            },
        },
        layout = wibox.layout.align.horizontal
    },
    widget = wibox.container.margin,
    top = beautiful.bar_top_gap,
}
-- }}}


-- watchers {{{

awful.widget.watch("amixer -c 0 -D pulse sget Master", 5, update_volume_widget, volume_widget)
awful.widget.watch("amixer -c 0 -D pulse sget Capture", 5, update_mic_widget, mic_widget)
awful.widget.watch("openvpn3 sessions-list", 20, update_vpn_widget, vpn_widget)
awful.widget.watch("iw dev wlo1 link", 20, update_network_widget, network_widget)
awful.widget.watch("acpi", 5, update_battery_widget, battery_widget)

-- }}}
