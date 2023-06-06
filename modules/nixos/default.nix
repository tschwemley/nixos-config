{ ... }:
{
	flake.nixosModules = {
		audio = import ./audio;
		hardware = import ./hardware;
		homeManager = import ./home-manager;
		k3s = import ./k3s;
		services = import ./services;
		system = import ./system;
		users = import ./users;
	};
}
