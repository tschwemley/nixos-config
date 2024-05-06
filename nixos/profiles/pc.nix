{pkgs, ...}: {
  imports = [
    ./.
    # TODO: evaluate if I need to use this
    ../programs/gamemode.nix
    ../programs/hyprland.nix
    ../programs/kdeconnect.nix
    ../programs/man.nix
    ../programs/qt.nix
    ../programs/steam.nix
    ../programs/wine.nix
    ../programs/xdg.nix
    ../services/dbus.nix
    ../services/gnome.nix
    ../services/ollama.nix
    ../system/fonts.nix
    ../system/greetd.nix
    ../system/security.nix
  ];

  # TODO: move locations?
  environment.systemPackages = with pkgs; [
    mariadb
  ];

  programs = {
    # this is required to make home manager managed GTK items function
    dconf.enable = true;
  };
}
