self:
(_: prev: {
  inherit (self.charm.packages.${prev.system}) crush;
})
