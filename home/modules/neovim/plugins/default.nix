{ pkgs, ... }:

{
	telescope = with pkgs.vimPlugins; {
		plugin = telescope-nvim;
		config = ''
		'';
	};
}
