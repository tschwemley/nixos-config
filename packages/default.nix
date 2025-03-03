pkgs: {
  anonymous-overflow = pkgs.callPackage ./anonymousoverflow.nix {};
  json2go = pkgs.callPackage ./json2go.nix {};
  raindrop = pkgs.callPackage ./raindrop.nix {};
  scripts = import ./scripts pkgs;
  tailscale = pkgs.callPackage ./tailscale.nix {};
  tree-sitter-bruno = pkgs.callPackage ./tree-sitter-bruno.nix {};
  wl-ocr = pkgs.callPackage ./wl-ocr.nix {};
}
