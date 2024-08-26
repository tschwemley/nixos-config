require("lspconfig").nil_ls.setup({
   autostart = true,
   settings = {
      ["nil"] = {
         -- formatting = {
         --    command = { "alejandra" },
         -- },
         --
         -- TODO: decide later if autoarchiving makes sense
         -- nix = {
         --   flake = {
         --     autoArchive = true,
         --   },
         -- },
      },
   },
})
