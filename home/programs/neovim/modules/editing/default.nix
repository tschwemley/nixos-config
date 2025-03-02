{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [nvim-sops];

  xdg.configFile = {
    "nvim/after/plugin/editing/nvim-sops.lua".source = ./nvim-sops.lua;
    "nvim/after/plugin/editing/mini-pairs.lua".text = "require('mini.pairs').setup()";
  };
}
