pkgs: {
  anonymous-overflow = pkgs.callPackage ./anonymousoverflow.nix {};
  extraVimPlugins = import ./vim-plugins pkgs;
  json2go = pkgs.callPackage ./json2go.nix {};
  nrepl = pkgs.callPackage ./nrepl.nix {};
  raindrop = pkgs.callPackage ./raindrop.nix {};
  scripts = import ./scripts pkgs;
  tailscale = pkgs.callPackage ./tailscale.nix {};
  tree-sitter-bruno = pkgs.callPackage ./tree-sitter-bruno.nix {};
  trmnl-server = pkgs.callPackage ./trmnl-server.nix {};
  wl-ocr = pkgs.callPackage ./wl-ocr.nix {};
}
