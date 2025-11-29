self:
(_: prev: {
  yaziPlugins = prev.yaziPlugins // self.packages.${prev.system}.yaziPlugins;
})
