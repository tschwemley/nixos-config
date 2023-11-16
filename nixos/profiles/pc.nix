{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./.
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../modules/hardware/audio.nix
    ../modules/system/fonts.nix
    ../modules/services/flatpak.nix
    ../modules/services/xserver.nix
    ../modules/users/schwem.nix
  ];
}
