self:
(_: prev: {
  vimPlugins = prev.vimPlugins // self.packages.${self.lib.system prev}.extraVimPlugins;
})
