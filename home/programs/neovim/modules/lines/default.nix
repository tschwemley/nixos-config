{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    bufferline-nvim
    lualine-nvim
  ];

  xdg.configFile."nvim/after/plugin/lines.lua".source = ./lines.lua;
}
