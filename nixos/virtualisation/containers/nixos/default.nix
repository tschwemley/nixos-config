{
  inputs,
  withSystem,
  ...
}: let
  mkContainer = name:
    withSystem "x86_64-linux" ({
      system,
      pkgs,
      ...
    }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {inherit inputs pkgs;};

        modules = [
          {
            boot.isContainer = true;
            imports = [
              inputs.sops.nixosModules.sops
            ];
            sops.age.keyFile = /root/.config/sops/age/keys.txt;
            system.stateVersion = "23.11";
          }
          ./${name}
        ];
      });
in {
  flake.nixosConfigurations = {
    keycloak = mkContainer "keycloak";
    searxng = mkContainer "searxng";
  };
}
