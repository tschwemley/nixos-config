self: pkgs: {
  extraVimPlugins = import ./vim-plugins pkgs;
  hueforge = pkgs.callPackage ./hueforge {inherit (self.inputs) hueforge;};
  json2go = pkgs.callPackage ./json2go.nix {};
  nrepl = pkgs.callPackage ./nrepl.nix {};
  raindrop = pkgs.callPackage ./raindrop.nix {};
  scripts = import ./scripts pkgs;
  tree-sitter-bruno = pkgs.callPackage ./tree-sitter-bruno.nix {};
  trmnl-server = pkgs.callPackage ./trmnl-server.nix {};
  wl-ocr = pkgs.callPackage ./wl-ocr.nix {};
  newsblur = pkgs.fetchFromGitHub {
    owner = "samuelclay";
    repo = "NewsBlur";
    rev = "2876dd1404708fdf580e80bf7cdb25ac8acbfc13";
    hash = "sha256-aLTqVyzCP414dvq0JnKL0ZL47cSEQnuIIOt6iso0lC0=";
    sparseCheckout = ["config" "docker" "node"];
  };
}
