{pkgs, ...}: {
  programs.neovim.plugins = [
    (import ./treesitter.nix pkgs)
  ];

  xdg.configFile."nvim/after/plugin/treesitter.lua".source = ./treesitter.lua;
}
