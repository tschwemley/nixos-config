{ self, inputs, ... }:
{
	flake.packages.x86_64-linux = {
      k3s-server-proxmox = inputs.nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          # you can include your own nixos configuration here, i.e.
          # ./configuration.nix
		  inputs.home-manager.nixosModule {
			home-manager.useGlobalPkgs = true;						
		    home-manager.useUserPackages = true;						
			home-manager.users.k3s = self.homeConfigurations.k3s;

			users.users.k3s = {
				isSystemUser = true;
				group  = "k3s";
			};

			system.stateVersion = "23.05";
		  }
          ../nixos/modules/k3s/server.nix
        ];
        format = "proxmox";
      };
	};
}
