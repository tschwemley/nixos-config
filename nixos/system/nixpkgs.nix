{ self, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = builtins.attrValues self.overlays;
  };
}
