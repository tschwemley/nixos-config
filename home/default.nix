{inputs, config, ...}: let
  mkHomeConfig = username: profiles:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
      modules = [
        ./profiles/common.nix
		{
			home.username = username;
			home.homeDirectory = "/home/${username}";
			home.stateVersion = "23.05";
		}
      ] ++ profiles;
    };
in {
  flake.homeConfigurations = {
    schwem = mkHomeConfig "schwem" [ ./profiles/pc.nix ];
  };
}
