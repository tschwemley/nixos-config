{
  imports = [
    ./vim-kitty-navigator.nix
  ];

  # programs.neovim.plugins = with pkgs.vimPlugins; [
  #   vim-kitty-navigator
  # ];

  # xdg.configFile."nvim/after/plugin/terminal.lua".source = ./terminal.lua;
}
