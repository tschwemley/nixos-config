{self, ...}: {
  nixpkgs = {
    config.allowUnfree = true;

    # NOTE: additional overlays may be set in nixos/profiles dependent on host type
    overlays = with self.overlays; [
      default
      neovim
      patched-packages
      vimPlugins
    ];
  };
}
