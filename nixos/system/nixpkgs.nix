{ self, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      android_sdk.accept_license = true;
    };

    overlays = with self.overlays; [
      default
      neovim
      vimPlugins
    ];
  };
}
