pkgs: {
  anonymous-overflow = pkgs.callPackage ./anonymousoverflow.nix {};
  json2go = pkgs.callPackage ./json2go.nix {};
  raindrop = pkgs.callPackage ./raindrop.nix {};
  tailscale = pkgs.callPackage ./tailscale.nix {};
  wl-ocr = pkgs.callPackage ./wl-ocr.nix {};
}
