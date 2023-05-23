{ self, inputs, ... }: 
let 
	mkSystem = configPath: inputs.nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			inputs.home-manager.nixosModule
			../modules/nixos/common.nix
			configPath
		];
	};
in
{
	flake.nixosConfigurations = {
		# office = mkSystem ./office.nix;
		# k3s-server = mkSystem ./k3s-server.nix;
		moltres = mkSystem ./moltres;
	};
}
