{ self, inputs, ... }:
let 
	modules = self.nixosModules;
in
{
	flake.nixosModules = {
		development = import ./development;
		display = import ./display;
		home-manager = inputs.home-manager.nixosModules.home-manager;
		gaming = import ./gaming;
		nixos = import ./nixos;
		pc = import ./pc;
		programs = import ./programs;
		services = import ./services;
		shell = import ./shell;
	};
}
