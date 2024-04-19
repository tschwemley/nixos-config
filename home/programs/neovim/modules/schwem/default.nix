{pkgs, ...}: {
  xdg.configFile = {
    # don't let hm manage my init.lua
    "nvim/init.lua".source = ./init.lua;

    # add personal files to lua/schwem
    "nvim/lua/schwem/helpers.lua".source = ./helpers.lua;
    "nvim/lua/schwem/keymap.lua".source = ./keymap.lua;
    "nvim/lua/schwem/set.lua".source = ./set.lua;
  };
}
