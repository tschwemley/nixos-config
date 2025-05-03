{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;

    defaultEditor = lib.mkDefault true;
    extraLuaConfig =
      /*
      lua
      */
      ''
        require('schwem.cmd')
        require('schwem.keymap')
        require('schwem.opts')
      '';

    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };
}
