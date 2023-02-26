{ self, inputs, ... }:
let 
	pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
	commonPkgs = {
		imports = [
			./../modules/programs/bat.nix
			./../modules/programs/git.nix	
			./../modules/programs/neovim.nix	
			./../modules/programs/nnn.nix	
			./../modules/programs/wezterm.nix
			./../modules/programs/zsh.nix
		];
		
		# TODO: should some of these be moved to devshell? dev home module?
		home.packages = with pkgs; [
			manix
			ripgrep
			tealdeer
			wireguard-tools
			wget

			#TODO: anything in here should be moved to appropriate place
		];
	};
in
{
	flake = {
		homeModules = {
			common = {
				home.stateVersion = "22.11";
				imports = [
					commonPkgs
				];
			};

			xServer = {
				imports = [
					./../modules/programs/awesome.nix
					./../modules/programs/barrier.nix
				];
				
				home.packages = with pkgs; [
					brave
					haruna
					sonic-pi
					vlc
				];
			};
		};
	};
}
