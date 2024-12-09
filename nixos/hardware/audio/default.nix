{inputs, ...}: {
  imports = [
    inputs.musnix.nixosModules.musnix

    ./bluetooth.nix
    ./pipewire.nix
    ./scarlett8i6.nix
  ];

  musnix.enable = true;
}
