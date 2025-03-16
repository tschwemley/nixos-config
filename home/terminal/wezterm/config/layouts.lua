-- local enums = require("enums")
local wezterm = require("wezterm")

---
-- Data definitions
---
local Layouts = {
   CUSTOM = 1,
   FAT = 2,
   GRID = 3,
   HORIZONTAL = 4,
   TALL = 5,
   VERTICAL = 6,
}

local Locations = {
   TOP = 1,
   RIGHT = 2,
   BOTTOM = 3,
   LEFT = 4,
}

--
local OrderedLayouts = {}
for name in pairs(Layouts) do
   OrderedLayouts[Layouts[name]] = name
end

local layout_config = {
   fat = {
      -- TODO: main_window_location = Locations.TOP, -- for now just assume top by default
      main_pane_location = Locations.TOP,
      split_percent = 0.2,
   },
   grid = {},
   horizontal = {},
   tall = {},
   vertical = {},
}

-- set the cur_layout in the wezterm GLOBAL (userdata value) to store into a global in-memory
-- table and ensure thread-safe access. default to the fat layout
wezterm.GLOBAL.cur_layout = Layouts.FAT

---
-- Local Functions
---
local function get_panes(window)
   return window:active_tab():panes_with_info()
end

---
-- Module Implementation
---
local M = {}

function M.cur_layout(layout_name)
   return wezterm.GLOBAL.cur_layout
end

function M.set_cur_layout(layout_name)
   if layout_name == nil or OrderedLayouts[layout_name] == nil then
      -- error if layout name is invalid
      error("invalid layout name provided to cur_layout")
   end
   wezterm.GLOBAL.cur_layout = layout_name
end

function M.next_layout()
   local next_key = M.cur_layout() + 1
   if next_key > #OrderedLayouts then
      next_key = 1
   end
   return OrderedLayouts[next_key]
end

function M.prev_layout()
   local prev_key = M.cur_layout() - 1
   if prev_key < 1 then
      prev_key = #OrderedLayouts
   end
   return OrderedLayouts[prev_key]
end

-- resize panes for the current layout
function M.resize_panes(window, pane)
   local window_size = window:active_tab():get_size()
   local panes = get_panes(window)

   if M.cur_layout() == Layouts.FAT then
      for pane in pairs(panes) do
         if pane.is_active then
         else
         end
      end
   end

   return true
end

function M.switch(window, pane, layout)
   local success = M.resize_panes(layout)
   if success then
      M.cur_layout(layout)
      -- TODO: else
   end
end

function M.switch_next(window, pane, layout)
   return M.switch(M.next_layout())
end

function M.switch_prev(window, pane, layout)
   return M.switch(M.prev_layout())
end

return M
