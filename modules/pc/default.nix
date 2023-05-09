{ ... }:

{
	imports = [
		./barrier.nix
	];

	environment.systemPackages = [
		brave
		firefox
		webcord-vencord
	];
}
