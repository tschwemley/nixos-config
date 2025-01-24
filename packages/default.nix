pkgs: {
  anonymous-overflow = pkgs.callPackage ./anonymousoverflow.nix {};
  compose2nix = pkgs.callPackage ./utils/compose2nix.nix {};
  json2go = pkgs.callPackage ./json2go.nix {};
  raindrop = pkgs.callPackage ./raindrop.nix {};
  wl-ocr = pkgs.callPackage ./wl-ocr.nix {};
}
