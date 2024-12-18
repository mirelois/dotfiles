-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("awful.autofocus")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Notification library
-- local naughty = require("naughty")

require("screen")

require("error")

require("bar")

-- Set keys
local keys = require("bindings")

require("rules").setup(keys.clientkeys, keys.clientbuttons)

require("signals")

require("startup")

