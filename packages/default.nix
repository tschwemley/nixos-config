self: pkgs: {
  android = import ./android pkgs;
  extraVimPlugins = import ./vim-plugins pkgs;
  hueforge = pkgs.callPackage ./hueforge {inherit (self.inputs) hueforge;};
  json2go = pkgs.callPackage ./json2go.nix {};
  nrepl = pkgs.callPackage ./nrepl.nix {};
  pomobar-rs = pkgs.callPackage ./pomobar-rs {};
  raindrop = pkgs.callPackage ./raindrop.nix {};
  scripts = import ./scripts pkgs;
  tree-sitter-bruno = pkgs.callPackage ./tree-sitter-bruno.nix {};
  trmnl-server = pkgs.callPackage ./trmnl-server.nix {};
  wl-ocr = pkgs.callPackage ./wl-ocr.nix {};

  # asepritePlugins.retro-diffusion = pkgs.python311Packages.buildPythonApplication {
  #   pname = "retro-diffusion";
  #   version = "13.5.0";
  #   src = /home/schwem/projects/ai/image/retro-diffusion/aseprite-extension/extension/python;
  # };
}
