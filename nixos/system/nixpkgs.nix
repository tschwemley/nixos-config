{self, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      self.overlays.default
      self.inputs.neovim-overlay.overlays.default
    ];
  };
}
