{...}: {
  imports = [
    ./.
    # TODO: evaluate if I need to use this
    # ../programs/gamemode.nix
    # TODO: uncomment this at some point
    ../programs/hyprland.nix
    ../programs/man.nix
    ../programs/qt.nix
    ../programs/steam.nix
    ../programs/wine.nix
    ../programs/xdg.nix
    ../network/mullvad.nix
    ../services/dbus.nix
    ../services/gnome.nix
    ../services/ollama.nix
    ../system/fonts.nix
    ../virtualisation/podman.nix
  ];

  programs = {
    # this is required to make home manager managed GTK items function
    dconf.enable = true;
  };

  # TODO: move to security
  # on my personal machines I don't want to be prompted for my pw
  security.sudo.wheelNeedsPassword = false;
}
