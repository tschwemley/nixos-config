{ pkgs, ... }:
let
  git = import ../programs/git.nix {
    inherit pkgs;
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in
{
  imports = [
    git

    ../programs/common.nix
    ../programs/development

    ../programs/bat.nix
    ../programs/btop.nix
    ../programs/fzf.nix
    ../programs/neovim
    ../programs/nnn.nix
    ../programs/ripgrep.nix
    ../xdg/ssh/default.nix
    ../terminal/shell
  ];

  home.stateVersion = "24.05";
  sops.defaultSopsFile = ../secrets.yaml;
}
