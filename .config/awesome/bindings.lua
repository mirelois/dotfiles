local awful = require("awful")
local gears = require("gears")

terminal = "kitty"
modkey = "Mod4"

program_launcher = [[rofi -no-lazy-grab -show drun -modi run,drun,window -theme $HOME/.config/rofi/launcher/style -drun-icon-theme \"candy-icons\"]]

return {
    awful.key(
    {modkey}, "Return",
    function ()
        awful.spawn(terminal)
    end),
    awful.key(
    {modkey}, "r",
    function ()
        awful.spawn(program_launcher)
    end),

}
