local helpers = {}

helpers.set_tabs = function(tab_size, expand_tab)
   if not (type(expand_tab) == "boolean") then
      expand_tab = true
   end

   vim.bo.tabstop = tab_size;     -- hard tab size
   vim.bo.shiftwidth = tab_size;  -- indentation size
   vim.bo.expandtab = expand_tab; -- use spaces instead of tab characters
   vim.bo.softtabstop = tab_size; -- number of spaces to use for tabs
end

return helpers
