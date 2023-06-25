{pkgs, ...}: let
in {
  imports = [
    ./neovim
    ./shell
  ];

  home.packages = [
  ];

  home.sharedModules = [];
}
