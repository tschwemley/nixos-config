# TODO: clean this up and standardize
{...}: {
  system.stateVersion = "23.05";
  home-manager.config = {...}: {
    imports = [../../home/profiles/droid.nix];
  };
}
