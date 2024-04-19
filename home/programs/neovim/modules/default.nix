{pkgs, ...}: {
  imports = [
    ./colors
    ./completion
    ./debug
    ./diagnostics
    ./filetypes
    ./lines
    ./lsp
    ./telescope
    # ./terminal
    ./treesitter
    ./schwem
    ./utils

    # ./lsp
    # ./completion.nix
    # ./db.nix
    # ./debugging.nix
    # ./editing.nix
    # ./git.nix
    # ./lsp.nix
    # ./navigation.nix
    # ./notes.nix
    # ./utils.nix
  ];

  # plugins that don't (yet) fit into a module are defined here
  # programs.neovim.plugins = with pkgs.vimPlugins; [
  #   better-escape-nvim
  #   toggleterm-nvim
  #   which-key-nvim
  # ];

  # TODO: this is a wip towards simplifying the config
  # programs.neovim.plugins = [
  #   (import ../plugins/lsp-plugin.nix {inherit (pkgs) vimPlugins;})
  # ];
}
