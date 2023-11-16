{self, ...}: {
  perSystem = {pkgs, system,...}: {
    packages = {
      build-keycloak = pkgs.dockerTools.buildLayeredImage {
        name = "keycloak";
        config = { 
          imports = [../nixos/containers/keycloak.nix];
          boot.isContainer = true;
        };
      };
    };
  };
}
