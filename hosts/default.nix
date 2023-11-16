{ self, inputs, config, lib, pkgs, utils, ... }:
let
	modules = self.nixosModules;
in
{
	flake = {
		nixosConfigurations = {
			#lux = import ./lux;
			office = { imports = [ ./office ]; };
		};
	};
}
