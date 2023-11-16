{ self, inputs, ... }:

{
	flake.nixosModules = {
		development = import ./development;
		gaming = import ./gaming;
		nixos = import ./nixos;
		pc = import ./pc;
		programs = import ./programs;
		services = import ./services;
		shell = import ./shell;
		xsession = import ./xsession;
		
		home-manager = inputs.home-manager.nixosModules.home-manager;
	};
}
