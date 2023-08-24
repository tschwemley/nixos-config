{self, ...}: let
  configurations =
    builtins.mapAttrs
    (name: config: {${name} = config.config.system.build.toplevel;})
    self.nixosConfigurations;
in {
  flake.hydraJobs = {
    inherit configurations;
  };
}
