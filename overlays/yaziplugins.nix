self:
(_: prev: {
  yaziPlugins = prev.yaziPlugins // self.packages.${self.lib.system prev}.yaziPlugins;
})
