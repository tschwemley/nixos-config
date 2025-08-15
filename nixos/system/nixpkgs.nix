{ self, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = with self.overlays; [
      default
      neovim
      vimPlugins
    ];
  };
}
