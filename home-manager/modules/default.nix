{ config, pkgs, ... }: 
let
	moduleArgs = {
		_module.args = {
			inherit config;
		};
	};
	shell = import ./shell;
in
{
	flake.homeModules = {
		_module.args.config = config;
		# audio = import ./audio;
		# desktop = import ./desktop;
		# development = import ./development;
		# gaming = import ./gaming;
		# neovim = import ./neovim { inherit pkgs; };
		shell = import ./shell { inherit config; };
		# terminal = import ./terminal;
	};
}
