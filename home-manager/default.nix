{ inputs, ... }: 
let 
	mkHomeConfig = profile: inputs.home-manager.lib.homeManagerConfiguration {
		imports = [ profile ];
	};
in
{
	flake.homeConfigurations = {
		desktop = import ./profiles/desktop.nix;
		laptop = import ./profiles/laptop.nix;
		server = import ./profiles/server.nix;
		work = import ./profiles/work.nix;
	};
}
