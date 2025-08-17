{ lib, ... }:
{
  imports = [
    ./formatters.nix
    ./lsp.nix
    ./plugins.nix
    ./treesitter.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };

  xdg.configFile = {
    "nvim".source = ./config;
  };
}
