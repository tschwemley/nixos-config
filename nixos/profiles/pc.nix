{...}: {
  imports = [
    ./.
    ../hardware/audio
    ../programs/barrier.nix
    ../programs/gamemode.nix
    ../programs/hyprland.nix
    ../programs/qt.nix
    ../programs/steam.nix
    ../programs/xdg.nix
    ../network/mullvad.nix
    ../services/gnome.nix
    ../services/ollama.nix
    ../system/fonts.nix
    ../system/man.nix
    ../system/wine.nix
    ../virtualisation/podman.nix
  ];

  # TODO: move to security
  # on my personal machines I don't want to be prompted for my pw
  security.sudo.wheelNeedsPassword = false;
}
