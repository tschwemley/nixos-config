{self, ...}: {
  imports = [./option.nix];
  perSystem = {
    pkgs,
    system,
    ...
  }: {
    containers = {
      keycloak = self.inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./keycloak.nix];
      };
    };
  };
}
