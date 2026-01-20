{ pkgs, ... }:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      # go
      go
      golines

      # kdl
      kdlfmt

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
