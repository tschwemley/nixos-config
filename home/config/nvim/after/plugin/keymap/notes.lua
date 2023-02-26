local wk = require "which-key"

wk.register {
  ["<leader>n"] = {
    name = "Notes",
    j = { "<cmd>Neorg workspace pkm<cr><cmd>Neorg journal today<cr>", "Journal" },
    k = { "<cmd>Neorg kanban toggle<cr>", "Kanban" },
    o = { "<cmd>Neorg workspace pkm<cr>", "Open Notes" },
  },
}

wk.register {
    ["<leader>v"] = { "<cmd>lua Toggle_venn()<cr>", "Toggle Venn" }
}

-- TODO: register ctrl-t to insert timestamp
-- :pu=strftime('%c')
-- Format String	Example output
-- %c	Thu 27 Sep 2007 07:37:42 AM EDT
-- %a %d %b %Y	Thu 27 Sep 2007
-- %b %d, %Y	Sep 27, 2007
-- %H:%M:%S	07:36:44
-- %T	07:38:09
-- %m/%d/%y	09/27/07
-- %y%m%d	070927
-- %x %X (%Z)	09/27/2007 08:00:59 AM (EDT)
-- %Y-%m-%d	2016-11-23
-- %F	2016-11-23 (works on some systems)
-- %d/%m/%y %H:%M:%S	27/09/07 07:36:32
