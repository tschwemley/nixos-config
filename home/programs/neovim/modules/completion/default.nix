{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    blink-compat # necessary for compat with any nvim-cmp plugins
    blink-cmp
    blink-cmp-env
    blink-emoji-nvim
    css-vars-nvim
    luasnip

    # compatability plugins (require blink-compat)
    cmp-dap
  ];

  xdg = {
    configFile = {
      "nvim/after/plugin/blink.lua".source = ./blink.lua;
      "nvim/after/plugin/luasnip.lua".source = ./luasnip.lua;
      "nvim/after/plugin/luasnip_helpers.lua".source = ./luasnip_helpers.lua;
    };

    dataFile."nvim/snippets".source = ./snippets;
    # dataFile."nvim/snippets/all.lua".source = ./snippets/all.lua;
    # dataFile."nvim/snippets/helpers.lua".source = ./snippets/helpers.lua;
    # dataFile."nvim/snippets/lua.lua".source = ./snippets/lua.lua;
    # dataFile."nvim/snippets/markdown.lua".source = ./snippets/markdown.lua;
    # dataFile."nvim/snippets/nix.lua".source = ./snippets/nix.lua;
  };
}
