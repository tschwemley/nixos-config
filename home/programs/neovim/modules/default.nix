{pkgs, ...}: {
  imports = [
    ./colors.nix
    ./completion.nix
    ./db.nix
    ./debugging.nix
    ./editing.nix
    ./languages.nix
    ./lsp.nix
    ./treesitter.nix
    ./navigation.nix
  ];

  # plugins that don't (yet) fit into a module are defined here
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    toggleterm-nvim
    which-key-nvim
  ];
}
