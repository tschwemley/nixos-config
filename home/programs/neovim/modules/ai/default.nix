{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    avante-nvim
    # codecompanion-nvim
  ];

  xdg.configFile = {
    "nvim/after/plugin/ai/avante.lua".source = ./avante.lua;
    # "nvim/after/plugin/ai/codecompanion.lua".source = ./codecompanion.lua;
  };
}
