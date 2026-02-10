{ pkgs, ... }:
{
  imports = [
    ./bluetooth.nix
    # ./jack.nix
    ./musnix.nix
    ./pipewire.nix
    ./scarlett8i6.nix
  ];

  environment.systemPackages = [ pkgs.alsa-utils ];
}
