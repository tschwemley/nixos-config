{
  inputs,
  withSystem,
  ...
}: let
  # mkHomeConfig = username: profiles:
  #   inputs.home-manager.lib.homeManagerConfiguration {
  #  inherit pkgs;
  #     modules = [
  # {
  # 	home.username = username;
  # 	home.homeDirectory = "/home/${username}";
  # }
  #       ./profiles/common.nix
  #     ] ++ profiles;
  #   };
in {
  flake.homeConfigurations = {
    # schwem = mkHomeConfig "schwem" [ ./profiles/pc.nix ];
    schwem = withSystem "x86_64-linux" ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./profiles/common.nix
          ./profiles/pc.nix
          {
            home.username = "schwem";
            home.homeDirectory = "/home/schwem";
          }
        ];
      });
  };
}
