pcall(require, "luarocks.loader")

-- Core
local awful = require("awful")
local gears = require("beautiful")

-- Theme
local beautiful = require("beautiful") -- theme library

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
