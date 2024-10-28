{ lib, ... }:
{
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    extraLuaConfig = # lua
      ''
        require('schwem.keymap')
        require('schwem.set')
      '';
    # extraLuaPackages = ps: with ps; [lua-utils-nvim];
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withNodeJs = false;
  };
}
