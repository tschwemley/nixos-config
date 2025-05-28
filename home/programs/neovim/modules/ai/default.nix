{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # avante-nvim

    # TODO: decide which, if any, of these plugins
    aider-nvim
    # codecompanion-nvim
  ];

  xdg.configFile = {
    "nvim/after/plugin/ai/aider.lua".source = ./aider.lua;
    # "nvim/after/plugin/ai/avante.lua".source = ./avante.lua;
    # "nvim/after/plugin/ai/codecompanion.lua".source = ./codecompanion.lua;
  };
}
