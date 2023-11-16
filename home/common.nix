{pkgs, ...}: let
in {
  imports = [
    ./neovim
    ./shell
  ];

  home.stateVersion = "23.05";
  home.packages = [
  ];

  home.sharedModules = [];
}
