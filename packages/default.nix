self: pkgs: {
  android = import ./android pkgs;
  extraVimPlugins = import ./vim-plugins pkgs;
  json2go = pkgs.callPackage ./json2go.nix { };
  nrepl = pkgs.callPackage ./nrepl.nix { };
  pomobar-rs = pkgs.callPackage ./pomobar-rs { };
  raindrop = pkgs.callPackage ./raindrop.nix { };
  scripts = import ./scripts pkgs;
  tdarr = import ./tdarr pkgs;
  trmnl-server = pkgs.callPackage ./trmnl-server.nix { };
  wezterm-nvim-navigator = pkgs.callPackage ./wezterm-nvim-navigator.nix { };
  wl-ocr = pkgs.callPackage ./wl-ocr.nix { };
  yaziPlugins = import ./yazi-plugins pkgs;

  # asepritePlugins.retro-diffusion = pkgs.python311Packages.buildPythonApplication {
  #   pname = "retro-diffusion";
  #   version = "13.5.0";
  #   src = /home/schwem/projects/ai/image/retro-diffusion/aseprite-extension/extension/python;
  # };

  # hueforge = pkgs.callPackage ./hueforge {inherit (self.inputs) hueforge;};
}
