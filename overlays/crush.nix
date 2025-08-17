self:
(_: prev: {
  inherit (self.inputs.charm.packages.${prev.system}) crush;
})
