{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    blink-compat # necessary for compat with any nvim-cmp plugins
    blink-cmp
    blink-cmp-env
    blink-emoji-nvim
    css-vars-nvim
    luasnip
  ];

  xdg = {
    configFile = {
      "nvim/after/plugin/blink.lua".source = ./blink.lua;
      "nvim/after/plugin/luasnip.lua".source = ./luasnip.lua;
    };

    dataFile."nvim/snippets".source = ./snippets;
  };
}
