{ pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      # go
      go
      golines

      # nix
      nixfmt

      # lua
      stylua

      # toml
      taplo
    ];

    plugins = with pkgs.vimPlugins; [
      conform-nvim
    ];
  };
}
