{pkgs, ...}: {
  # REF: https://github.com/echasnovski/mini.nvim?tab=readme-ov-file#modules
  programs.neovim.plugins = [pkgs.vimPlugins.mini-nvim];

  xdg.configFile = {
    "nvim/after/plugin/mini/init.lua".source = ./init.lua;
    "nvim/after/plugin/mini/clue.lua".source = ./clue.lua;
  };
}
