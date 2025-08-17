self:
(_: prev: {
  nixpkgs.config.allowUnfree = true;
  inherit (self.inputs.charm.packages.${prev.system}) crush;
})
