{inputs, config, ...}: let
  pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
  mkHomeConfig = username: profiles:
    inputs.home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
      modules = [
		{
			home.username = username;
			home.homeDirectory = "/home/${username}";
		}
        ./profiles/common.nix
      ] ++ profiles;
    };
in {
  flake.homeConfigurations = {
    schwem = mkHomeConfig "schwem" [ ./profiles/pc.nix ];
  };
}
