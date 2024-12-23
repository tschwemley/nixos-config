{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./.

    ../hardware/audio
    ../hardware/flipperzero.nix

    ../programs/gamemode.nix
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
    # ../services/rclone/flareon.nix
    # ../services/rclone/jolteon.nix
    # ../services/rclone/tentacool.nix
    ../services/upower.nix

    ../system/fonts.nix
    ../system/greetd.nix
    ../system/security.nix
  ];

  musnix.enable = true;

  # this is required to make home manager managed GTK items function
  programs.dconf.enable = true;

  services = {
    getty.autologinUser = "schwem";

    rclone = {
      enableFlareon = true;
      enableJolteon = true;
      enableTentacool = true;
    };
    resolved.dnsovertls = lib.mkDefault "true";
    tailscale.extraUpFlags = ["--advertise-tags=tag:pc"];
  };

  time.timeZone = "America/New_York";
  users.mutableUsers = true; # allow mutable users on non-servers
}
