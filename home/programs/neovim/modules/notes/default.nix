{pkgs, ...}: {
  imports = [./tiddlywiki.nix];

  programs.neovim = {
    extraLuaPackages = luaPkgs:
      with luaPkgs; [
        lua-utils-nvim
        nvim-nio
        pathlib-nvim
      ];

    plugins = with pkgs.vimPlugins; [
      neorg
      neorg-telescope
      # venn-nvim
    ];
  };

  xdg.configFile = {
    "nvim/after/plugin/neorg.lua".source = ./neorg.lua;
    # "nvim/after/plugin/venn.lua".source = ./venn.lua;
  };
}
