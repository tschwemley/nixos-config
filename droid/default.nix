{
  inputs,
  withSystem,
  ...
}:
{
  flake.nixOnDroidConfigurations.default = withSystem "aarch64-linux" (
    { pkgs, ... }:
    inputs.nix-on-droid.lib.nixOnDroidConfigurations {
      inherit pkgs;
      modules = [
        {
          system.stateVersion = "24.11";
          home-manager.config = ../home/profiles/default.nix;
        }
      ];
    }
  );
}
