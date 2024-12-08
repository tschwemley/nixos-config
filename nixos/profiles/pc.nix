{
  inputs,
  pkgs,
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
    ../programs/wine.nix
    ../programs/xdg.nix

    ../services/colord.nix
    ../services/dbus.nix
    ../services/gnome.nix
    ../services/rclone/flareon.nix
    ../services/rclone/jolteon.nix
    ../services/rclone/tentacool.nix
    ../services/upower.nix

    ../system/fonts.nix
    ../system/greetd.nix
    ../system/security.nix
  ];

  # TODO: move locations?
  environment.systemPackages = with pkgs; [
    mariadb
    usbutils
  ];

  musnix.enable = true;

  # this is required to make home manager managed GTK items function
  programs.dconf.enable = true;

  services = {
    getty.autologinUser = "schwem";
    tailscale.extraUpFlags = ["--advertise-tags=tag:pc"];
  };
}
