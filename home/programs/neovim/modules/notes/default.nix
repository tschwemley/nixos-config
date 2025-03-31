{pkgs, ...}: {
  imports = [./tiddlywiki.nix];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # venn-nvim
    ];
  };

  xdg.configFile = {
    # "nvim/after/plugin/venn.lua".source = ./venn.lua;
  };
}
