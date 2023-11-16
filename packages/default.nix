{ self, inputs, ... }:
let
    modules = ../nixos/modules;
in
{
	flake.packages.x86_64-linux = {
      k3s-server-proxmox = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          # you can include your own nixos configuration here, i.e.
          # ./configuration.nix
		  self.nixosModules
		  inputs.home-manager.nixosModule {
			home-manager.useGlobalPkgs = true;						
		    home-manager.useUserPackages = true;						
			home-manager.users.schwem = self.homeConfigurations.k3s
		  }
          ${modules}/k3s/server.nix
        ];
        format = "proxmox";
      };
}
