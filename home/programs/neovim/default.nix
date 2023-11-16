{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile = {
    "nvim/lua".source = ./xdg-config/lua;
    "nvim/after".source = ./xdg-config/after;
  };
}
