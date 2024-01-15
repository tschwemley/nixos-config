{...}: {
  imports = [
    ./.
    ../modules/hardware/audio
    ../modules/programs/barrier.nix
    ../modules/programs/steam.nix
    ../modules/services/mullvad.nix
    ../modules/services/gnome.nix
    ../modules/services/ollama.nix
    ../modules/services/xserver.nix
    ../modules/system/fonts.nix
    ../modules/system/gamemode.nix
    ../modules/system/man.nix
    ../modules/system/podman.nix
    ../modules/system/wine.nix
    ../modules/users/schwem.nix
    ../modules/wayland
  ];

  # on my personal machines I don't want to be prompted for my pw
  security.sudo.wheelNeedsPassword = false;
}
