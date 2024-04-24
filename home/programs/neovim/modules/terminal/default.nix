{pkgs, ...}: {
  imports = [
    ./vim-kitty-navigator.nix
  ];

  # xdg.configFile."nvim/after/plugin/terminal.lua".source = ./terminal.lua;
}
