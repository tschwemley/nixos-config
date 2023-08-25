{self, ...}: let
  inherit (self.inputs.nixpkgs.lib) mapAttrs;
  getHostConfig = _: config: config.config.system.build.toplevel;
in {
  flake.hydraJobs = {
    hosts = mapAttrs getHostConfig self.outputs.nixosConfigurations;
  };
}
