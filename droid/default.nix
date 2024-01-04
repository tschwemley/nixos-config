{inputs, ...}: {
  flake.nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    modules = [
      {
        system.stateVersion = "23.05";
        home-manager.config = ../home/profiles/pc.nix;
      }
    ];
  };
}
