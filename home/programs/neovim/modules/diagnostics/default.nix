{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    todo-comments-nvim
    trouble-nvim
  ];

  xdg.configFile."nvim/after/plugin/diagnostics.lua".source = ./diagnostics.lua;
}
