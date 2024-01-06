{inputs, ...}: {
  flake.nixOnDroidConfigurations.default = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    modules = [
      ../nixos/profiles/droid.nix
    ];
  };
}
