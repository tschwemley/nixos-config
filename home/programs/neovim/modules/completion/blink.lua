require("blink.cmp").setup({
   keymap = { preset = "super-tab" },
   snippets = { preset = "luasnip" },
   sources = {
      per_filetype = {
         sql = { "snippets", "dadbod", "buffer" },
      },

      providers = {
         dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
   },
})
