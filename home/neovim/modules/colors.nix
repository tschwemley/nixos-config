{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      gruvbox-material
    ];
    extraLuaConfig = ''
		require 'schwem.colors'	
	'';
  };
}
