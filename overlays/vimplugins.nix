self: (_: prev: {
  vimPlugins =
    prev.vimPlugins
    // self.packages.${prev.system}.extraVimPlugins;
})
