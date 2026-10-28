{ pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      # go
      go
      golines

      # kdl
      kdlfmt

      # lua
      stylua

      # nix
      nixfmt

      # php
      phpPackages.php-codesniffer

      # toml
      taplo
    ];

    plugins = with pkgs.vimPlugins; [
      conform-nvim
    ];
  };
}
