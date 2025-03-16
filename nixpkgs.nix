# NOTE: this file is currently unused... deciding if I like this implementation or not
{
  self,
  system,
  ...
}: let
  overlays = [
    self.overlays.default
    self.inputs.neovim-overlay.overlays.default
  ];

  # apply packages if there are any
  patches = [
    # remove once merged: https://nixpkgs-tracker.ocfox.me/?pr=386864
    (builtins.fetchurl {
      url = "https://patch-diff.githubusercontent.com/raw/NixOS/nixpkgs/pull/386864.patch";
      sha256 = "sha256-S63Es9QRSfSFPGWDdrOG7iucx+F/HDnHqdJm/+cY+fw=";
    })
  ];

  nixpkgs' =
    if self.lib.lists.length patches == 0
    then self.inputs.nixpkgs
    else
      (import self.inputs.nixpkgs {
        inherit (self) lib;
        inherit overlays system;
      })
      .applyPatches {
        inherit patches;
        name = "nixpkgs-patched";
        src = self.inputs.nixpkgs;
      };
in
  import nixpkgs' {
    inherit (self) lib;
    inherit overlays system;

    config.allowUnfree = true;
  }
