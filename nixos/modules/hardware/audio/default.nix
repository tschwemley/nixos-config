{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    ./pipewire.nix
    ./scarlett8i6.nix
  ];

  hardware.bluetooth.enable = true;
  musnix.enable = true;

  sound.enable = true;
}
