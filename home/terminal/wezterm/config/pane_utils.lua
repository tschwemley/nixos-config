local wezterm = require("wezterm")

local M = {}

-- Layout Enumeration (Concise Integer Representation)
local Layout = {
   FAT = 1,
   GRID = 2,
   HORIZONTAL = 3,
   TALL = 4,
   VERTICAL = 5,
}

wezterm.GLOBAL.current_layout = Layout.FAT
M.Layout = Layout -- Expose enum to the outside

-- Reverse Mapping for Layout Names (Debugging/Logging)
local LayoutNames = {}
for k, v in pairs(Layout) do
   LayoutNames[v] = k
end

--- Calculates the position and sizes for panes based on the specified layout.
--- @param tab wezterm.Tab The tab to layout.
--- @param layout integer One of `Layout.FAT`, `Layout.GRID`, `Layout.HORIZONTAL`, `Layout.TALL`, or `Layout.VERTICAL`.
local function apply_layout(tab, layout)
   local dimensions = tab:get_dimensions()
   if not dimensions then
      wezterm.log_error("Failed to get tab dimensions for layout")
      return
   end

   local width = dimensions.width
   local height = dimensions.height
   local panes = tab:panes()
   local num_panes = #panes
   if num_panes == 0 then
      return -- Nothing to layout
   end

   -- Helper function to apply size and move a pane.
   local function set_pane_geometry(pane, x, y, w, h)
      pane:set_size(w, h)
      pane:move(x, y)
   end

   -- Apply specific layout logic
   if layout == Layout.FAT then
      -- First pane is "fat", others are stacked on the side
      if num_panes > 1 then
         local fat_width = width * 0.6 -- adjust
         local side_width = width - fat_width
         local pane_height = height / (num_panes - 1)

         set_pane_geometry(panes[1], 0, 0, fat_width, height) -- Fat Pane

         for i = 2, num_panes do
            local y = (i - 2) * pane_height
            set_pane_geometry(panes[i], fat_width, y, side_width, pane_height)
         end
      elseif num_panes == 1 then
         set_pane_geometry(panes[1], 0, 0, width, height) -- Single pane occupies the whole space
      end
   elseif layout == Layout.GRID then
      local grid_cols = math.ceil(math.sqrt(num_panes))
      local grid_rows = math.ceil(num_panes / grid_cols)

      local pane_width = width / grid_cols
      local pane_height = height / grid_rows
      local pane_index = 1

      for row = 1, grid_rows do
         for col = 1, grid_cols do
            if pane_index <= num_panes then
               local x = (col - 1) * pane_width
               local y = (row - 1) * pane_height

               set_pane_geometry(panes[pane_index], x, y, pane_width, pane_height)
               pane_index = pane_index + 1
            end
         end
      end
   elseif layout == Layout.HORIZONTAL then
      local pane_width = width / num_panes
      for i, pane in ipairs(panes) do
         set_pane_geometry(pane, (i - 1) * pane_width, 0, pane_width, height)
      end
   elseif layout == Layout.TALL then
      if num_panes > 1 then
         local tall_width = width * 0.6 -- Main Area size
         local side_width = width - tall_width
         local pane_height = height / (num_panes - 1)

         set_pane_geometry(panes[1], 0, 0, tall_width, height) -- Tall area

         for i = 2, num_panes do
            local y = (i - 2) * pane_height
            set_pane_geometry(panes[i], fat_width, y, side_width, pane_height)
         end
      else
         -- Only one pane: Take up the whole space.
         set_pane_geometry(panes[1], 0, 0, width, height)
      end
   elseif layout == Layout.VERTICAL then
      local pane_height = height / num_panes
      for i, pane in ipairs(panes) do
         set_pane_geometry(pane, 0, (i - 1) * pane_height, width, pane_height)
      end
   else
      wezterm.log_warn("Unsupported layout: " .. (LayoutNames[layout] or tostring(layout))) -- Debugging
   end
end

--- Applies a named layout to the current tab.
--- @param layout integer One of `Layout.FAT`, `Layout.GRID`, `Layout.HORIZONTAL`, `Layout.TALL`, or `Layout.VERTICAL`.
function M.apply_layout_to_tab(layout)
   local tab = window:active_tab()
   if not tab then
      wezterm.log_error("No active tab")
      return
   end

   apply_layout(tab, layout)
end

--- Function that generates a layout cycling callback.
--- @param config table Wezterm Config options, where we retrieve `layout_order`. `layout_order` should use the `Layout.*` enum values.
--- @return function a closure function that can be installed as callback action in keys.
function M.cycle_layouts(config)
   local default_layouts = { Layout.FAT, Layout.GRID, Layout.HORIZONTAL, Layout.TALL, Layout.VERTICAL }
   local layouts = config.layout_order or default_layouts

   return function(window, pane)
      local tab = window:active_tab()
      if not tab then
         wezterm.log_warn("No active tab to cycle layouts")
         return
      end

      -- Get or initialize the layout index for THIS tab.
      local current_layout_index = wezterm.GLOBAL.current_layout or 1
      local next_layout_index = current_layout_index + 1

      if next_layout_index > #layouts then
         next_layout_index = 1
      end

      local next_layout = layouts[next_layout_index]

      M.apply_layout_to_tab(next_layout)

      -- Store New Index in a user variable associated with the Tab.
      wezterm.GLOBAL.current_layout = next_layout
   end
end

return M
