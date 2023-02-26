local neorg = require "neorg"

neorg.setup {
  load = {
    -- "Core" Modules
    ["core.defaults"] = {},

    ["core.integrations.telescope"] = {},

    ["core.keybinds"] = {},

    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },

    ["core.norg.concealer"] = {},

    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          pkm = "$HOME/notes",
        },
      },
    },

    ["core.norg.esupports.metagen"] = {
      config = {
          type = "auto"
      },
    },
  },
}
