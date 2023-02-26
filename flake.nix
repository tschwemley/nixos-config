{
	# I was debating putting these with their respective module(s) but for now I like having the 
	# visiblity in the root 
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		devshell.url = "github:numtide/devshell";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = inputs@{ flake-parts, nixpkgs, home-manager, ... }:
		flake-parts.lib.mkFlake { inherit inputs; } rec {
			systems = [ "x86_64-linux" "x86_64-darwin" ];
			
			perSystem = { config, self', inputs', pkgs, system, ... }: {
				# ensure pkgs accessible to perSystem/withSystem calls
				_module.args.pkgs = inputs'.nixpkgs.legacyPackages;
			};

			imports = [
				./lib
				./modules/audio
				./home
				./users
				./hosts
			];
		};
}
#---
# Reference
# - https://search.nixos.org/
# - https://mipmip.github.io/home-manager-option-search/
#---
