{ pkgs, ... }:
{
  imports = [
    ./bluetooth.nix
    ./musnix.nix
    ./pipewire.nix
    ./scarlett8i6.nix
  ];

  environment.systemPackages = [ pkgs.alsa-utils ];
}
