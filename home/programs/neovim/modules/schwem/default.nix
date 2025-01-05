{
  imports = [./fun.nix];

  xdg.configFile = {
    "nvim/lua/schwem/helpers.lua".source = ./helpers.lua;
    "nvim/lua/schwem/keymap.lua".source = ./keymap.lua;
    "nvim/lua/schwem/opts.lua".source = ./opts.lua;
  };
}
