{
  lib,
  pkgs,
  ...
}: {
  # imports = [
  #   ./modules
  # ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    # extraLuaPackages = ps: with ps; [lua-utils-nvim];
    plugins = import ./plugins pkgs.vimPlugins;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };

  # link neovim config to $HOME/.config/nvim
  xdg.configFile = {
    "nvim".source = ./config;
  };
}
