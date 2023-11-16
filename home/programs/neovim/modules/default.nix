{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./colors.nix
    ./completion.nix
    ./db.nix
    ./debugging.nix
    ./editing.nix
    ./treesitter.nix
    ./lsp.nix
    ./navigation.nix
  ];

  # plugins that don't fit into a module are defined here
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    toggleterm-nvim
    which-key-nvim
  ];
}
