{
  inputs,
  withSystem,
  ...
}: let
  mkHome = system: user: profile:
    withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
		{
		  nixpkgs = {
			config = {
			  allowUnfree = lib.mkDefault true;
			  # TODO: check if this is still necessary with my current config
			  # necessary due to home manager BUG: https://github.com/nix-community/home-manager/issues/2942#issuecomment-1119760100
			  allowUnfreePredicate = pkg: true;
			};
		  };
		}
          profile
          {
            home.username = user;
            home.homeDirectory = "/home/${user}";
          }
        ];
      });
in {
  flake.homeConfigurations = {
    schwem = mkHome "x86_64-linux" "schwem" ./profiles/pc.nix;
    "work@dev" = mkHome "x86_64-linux" "tschwemley" ./profiles/work.nix;
    "work@mac" = mkHome "x86_64-darwin" "tschwemley" ./profiles/work.nix;
  };
}
