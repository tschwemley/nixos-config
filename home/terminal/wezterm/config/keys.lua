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
      mods = "CTRL|SHIFT",
      action = wezterm.action_callback(function(window, pane)
         local direction = "Down"
         local size = { Cells = 20 }
         print("num panes:", #pane:tab():panes())
         if #pane:tab():panes() > 1 then
            direction = "Right"
            size = nil
         end

         return pane:split({
            direction = direction,
            size = size,
            command = { args = { "zsh" } },
         })
      end),
   },
   {
      key = "%",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
   },
   {
      key = '"',
      mods = "CTRL|SHIFT",
      -- action = action.SplitVertical({ domain = "CurrentPaneDomain", size = { Percent = 15 }, }),
      action = wezterm.action_callback(function(window, pane)
         -- When using pane:split(), 'size' works to set the dimension of the new pane.
         -- The direction relates to the new pane's position relative to the current one.
         -- 'CurrentPaneDomain' is the default for pane:split(), so it's often not needed.
         return pane:split({
            direction = "Bottom",
            size = 22,
         })
      end),
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
