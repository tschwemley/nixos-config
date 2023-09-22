{...}: {
  imports = [
    ./.
    ../modules/hardware/audio.nix
    ../modules/programs/barrier.nix
    ../modules/services/mullvad.nix
    ../modules/programs/steam.nix
    ../modules/services/xserver.nix
    ../modules/system/fonts.nix
    ../modules/system/man.nix
    ../modules/system/podman.nix
    ../modules/system/xdg.nix
    ../modules/users/schwem.nix
    ../modules/wayland
  ];

  # on my personal machines I don't want to be prompted for my pw
  security.sudo.wheelNeedsPassword = false;
}
