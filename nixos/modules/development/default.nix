{ pkgs, ... }:

{
	flake = {
		nixosModules = {
			development = {
				imports = [ ./direnv.nix ];
				
				environment.systemPackages = with pkgs; [
					cargo
					curl
					go
					lua
					manix
					nodejs
					rustc
					python
					tealdeer
					wget
					zig
				];
			};
		};
	};
}
