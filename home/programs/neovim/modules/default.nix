{pkgs, ...}: {
  imports = [
    ./colors
    ./completion
    ./db
    ./debug
    ./diagnostics
    ./editing
    ./filetypes
    ./lines
    ./lsp
    ./notes
    ./telescope
    ./terminal
    ./treesitter
    ./schwem
    ./ui
    ./utils
  ];

  # plugins imported here are used in multiple locations
  programs.neovim.plugins = with pkgs.vimPlugins; [
    mini-nvim
  ];
}
