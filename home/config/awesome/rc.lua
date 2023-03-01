pcall(require, "luarocks.loader")

-- Core
local awful = require("awful")
local gears = require("gears")

-- Theme
local beautiful = require("beautiful") -- theme library

-- Widgets
local vicious = require("vicious")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
terminal = "wezterm"
