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

    # node is sometimes used as a plugin dependency. E.g. for some debuggers/lsp tools
    extraPackages = [pkgs.nodejs];

    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
    withNodeJs = false;
  };
}
