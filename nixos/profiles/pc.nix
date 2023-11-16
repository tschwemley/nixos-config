{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./.
    ../modules/hardware/audio.nix
    ../modules/programs/barrier.nix
    ../modules/services/mullvad.nix
    ../modules/programs/steam.nix
    ../modules/system/fonts.nix
    ../modules/services/xserver.nix
    ../modules/users/schwem.nix
  ];

  # on my personal machines I don't want to be prompted for my pw
  security.sudo.wheelNeedsPassword = false;
}
