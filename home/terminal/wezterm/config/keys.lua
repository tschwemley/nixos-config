local wezterm = require("wezterm")

local action = require("wezterm").action
-- local pane_utils = require("pane_utils")
local layouts = require("layouts")

return {
   {
      key = "D",
      mods = "CTRL|SHIFT",
      action = action.ShowDebugOverlay,
      description = "Open Wezterm debug overlay",
   },
   {
      key = "l",
      mods = "CTRL|ALT",
      action = action.SendKey({ key = "l", mods = "CTRL" }),
      description = "Clear screen",
   },
   --
   -- pane management
   {
      key = "Enter",
      mods = "CTRL",
      action = wezterm.action_callback(function(window, pane)
         local num_panes = #window:get_panes()
         
         if num_panes == 1 then
            -- First pane - split bottom with 20% height
            pane:split({ direction = "Down", size = 0.2 })
         else
            -- For multiple panes, split right in bottom pane with equal widths
            local root_pane = window:get_root_pane()
            local bottom_pane = root_pane:child(1) -- Get the bottom pane from initial split
            local num_bottom_panes = #bottom_pane:get_children() or 1
            local new_size = 100 / (num_bottom_panes + 1)
            
            bottom_pane:split({
               direction = "Right",
               size = new_size
            })
         end
      end),
      description = "Smart split pane (bottom/right with proportional sizing)",
   },
   {
      key = "%",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
   },
   {
      key = '"',
      mods = "CTRL|SHIFT",
      action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
   },
   {
      key = "h",
      mods = "CTRL",
      action = action.ActivatePaneDirection("Left"),
   },
   {
      key = "l",
      mods = "CTRL",
      action = action.ActivatePaneDirection("Right"),
   },
   {
      key = "k",
      mods = "CTRL",
      action = action.ActivatePaneDirection("Up"),
   },
   {
      key = "j",
      mods = "CTRL",
      action = action.ActivatePaneDirection("Down"),
   },
   -- {
   --    key = "l",
   --    mods = "CTRL|SHIFT",
   --    action = wezterm.action_callback(pane_utils.cycle_layouts({})),
   --    description = "Cycle layouts",
   -- },
}
