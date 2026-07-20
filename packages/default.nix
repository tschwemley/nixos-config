self: pkgs: with pkgs; {
  android = import ./android pkgs;
  azeron-linux = callPackage ./azeron-linux.nix { };
  extraVimPlugins = import ./vim-plugins pkgs;
  json2go = callPackage ./json2go.nix { };
  nrepl = callPackage ./nrepl.nix { };
  raindrop = callPackage ./raindrop.nix { };
  scripts = import ./scripts pkgs;
  tdarr = import ./tdarr pkgs;
  trmnl-server = callPackage ./trmnl-server.nix { };
  wezterm-nvim-navigator = callPackage ./wezterm-nvim-navigator.nix { };
  wl-ocr = callPackage ./wl-ocr.nix { };
  yaziPlugins = import ./yazi-plugins pkgs;

  # stoat-server = callPackage ./stoat/stoat-server.nix { };
  # zulip-server = callPackage ./zulip-server.nix { };

  # reference =
  #   let
  #     version = "20260604";
  #   in
  #   pkgs.stdenv.mkDerivation {
  #     inherit version;
  #
  #     src = fetchFromGitHub {
  #       owner = "Fechin";
  #       repo = "reference";
  #       tag = "main";
  #       hash = "sha256-tn/SGcc+NBmSaxcRNSyvBJ0ICA1iEWu8PNeQXWQNJwI=";
  #     };
  #
  #     passthru.updateScript = pkgs.nix-update-script { };
  #   };

  # asepritePlugins.retro-diffusion = pkgs.python311Packages.buildPythonApplication {
  #   pname = "retro-diffusion";
  #   version = "13.5.0";
  #   src = /home/schwem/projects/ai/image/retro-diffusion/aseprite-extension/extension/python;
  # };

  # hueforge = callPackage ./hueforge {inherit (self.inputs) hueforge;};
}
