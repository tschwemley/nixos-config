{ self, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;

    # NOTE: additional overlays may be set elsewhere (e.g. nixos/profiles) dependent on host type
    overlays = with self.overlays; [
      default
      neovim
      patchedPackages
      vimPlugins
    ];
  };
}
