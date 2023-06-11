{ inputs, homeModules, withSystem, ... }: 
let
	commonModules = [
		homeModules
	];

	homeManagerConfiguration = inputs.home-manager.lib.homeManagerConfiguration;
	moduleArgs = { _module.args.homeModules = homeModules; };
	mkHome = profile: withSystem "x86_64-linux" ({pkgs, ...}: homeManagerConfiguration {
		inherit pkgs;
		
		modules = [
			moduleArgs
			profile
		];		
	});
in
{
	flake.homeConfigurations = {
		# desktop = mkhome ./desktop.nix;
		k3s = mkHome ./k3s.nix;
		# work = import ./work.nix;
	};
}
