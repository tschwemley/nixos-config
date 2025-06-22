self:
(_: prev: {
  inherit (self.inputs.nixpkgs-small.legacyPackages.${prev.system}) rocmPackages;
})
