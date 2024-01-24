{inputs, ...}: {
  flake.nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    modules = [
      {
        home-manager.config = ../home/profiles/droid.nix;
      }
    ];
  };
}
