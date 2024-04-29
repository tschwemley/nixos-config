{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    neorg
    neorg-telescope
    venn-nvim
  ];

  xdg.configFile = {
    "nvim/after/plugin/neorg.lua".source = ./neorg.lua;
    "nvim/after/plugin/venn.lua".source = ./venn.lua;
  };
}
