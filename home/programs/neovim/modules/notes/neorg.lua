require("neorg").setup({
   load = {
      ["core.defaults"] = {
         config = {
            disable = {
               -- module list goes here
               "core.autocommands",
               "core.itero",
            },
         },
      },
      ["core.concealer"] = {},
      ["core.ui.calendar"] = {},
   },
})
