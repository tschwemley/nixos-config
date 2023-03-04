{ self, inputs, config, ... }:
let
	pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
	commonSystemPackages = with pkgs; {
		environment.systemPackages = with pkgs; [
			#bun
			cargo
			libva # for video acceleration
			nodejs
			rustc
			rustfmt
		];
	};
in
{
	flake = {
		nixosConfigurations = { 
			office = self.lib.mkLinuxSystem {
				imports = with pkgs; [ 
					self.nixosModules.home-manager
					self.users.pcs
					self.audio.all
					./../modules/fonts
					./../modules/desktop/steam.nix
					./office
					commonSystemPackages	
				];
			};

			luxembourg = self.lib.mkLinuxSystem {
				imports = with pkgs; [ 
					self.nixosModules.home-manager
					self.users.cloud.lux
					./luxembourg
				];
			};
		};
	};
}
