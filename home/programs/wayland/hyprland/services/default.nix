{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  # define services w/o tons of options in place
  services = {
    hyprpolkitagent.enable = true;
  };
}
