{
  config,
  inputs,
  lib,
  ...
}: {
  # TODO: uncomment below after unfucking my shit up for the asdfa321349873210348723 time
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./.

    ../hardware/audio
    ../hardware/flipperzero.nix

    # ../programs/gamemode.nix
    ../programs/hyprland.nix
    ../programs/kdeconnect.nix
    ../programs/keyboards
    ../programs/lutris.nix
    ../programs/man.nix
    ../programs/steam.nix
    ../programs/usbutils.nix
    ../programs/wine.nix
    ../programs/xdg.nix

    ../services/colord.nix
    ../services/dbus.nix
    ../services/gnome.nix
    ../services/upower.nix

    ../security/onlykey.nix

    ../system/documentation.nix
    ../system/greetd.nix
    ../system/security.nix
  ];

  nix.settings.trusted-users = ["schwem"];

  # this is required to make home manager managed GTK items function
  programs.dconf.enable = true;

  services = {
    getty.autologinUser = "schwem";

    rclone = {
      enableFlareon = true;
      enableJolteon = true;
      enableTentacool = true;
      enableZapados = true;
    };

    resolved.dnsovertls = lib.mkDefault "true";
    tailscale.extraUpFlags = ["--advertise-tags tag:pc"];
  };

  time.timeZone = "America/New_York";
  users.mutableUsers = true; # allow mutable users on non-servers
}
