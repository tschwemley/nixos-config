{...}: {
  imports = [
    ./.
    ../modules/hardware/audio.nix
    ../modules/programs/barrier.nix
    # BUG: currently fails due to iproute/etc not existing. Either keep or move off to a custom
    #      systemd-networkd config
    ../modules/services/mullvad.nix
    ../modules/programs/steam.nix
    ../modules/services/xserver.nix
    ../modules/system/fonts.nix
    ../modules/system/gamemode.nix
    ../modules/system/man.nix
    ../modules/system/podman.nix
    ../modules/users/schwem.nix
    ../modules/wayland
  ];

  # on my personal machines I don't want to be prompted for my pw
  security.sudo.wheelNeedsPassword = false;
}
