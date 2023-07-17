{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkDefault true;
	# plugins = with lib.types.submobule; [
	# 	comment
	# ];
   #  plugins = with pkgs.vimPlugins; [
   #    # I don't know where to put these ones yet
	  # comment
   #    nvim-luadev
   #    toggleterm-nvim
   #    which-key-nvim
			#
   #    # call the doctor, we diagnosing shit
   #    trouble-nvim
   #  ];
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  xdg.configFile = {
    "nvim/lua".source = ../xdg-config/nvim/lua;
    "nvim/ftplugin".source = ../xdg-config/nvim/ftplugin;
  };
}
