{
  inputs,
  lib,
  ...
}: {
  # TODO: uncomment below after unfucking my shit up for the asdfa321349873210348723 time
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./.

    ../development/android.nix
    ../development/embedded.nix

    ../hardware/audio
    ../hardware/flipperzero.nix

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
    ../services/gamemode.nix
    ../services/gnome.nix
    ../services/libinput.nix
    ../services/upower.nix

    ../security/onlykey.nix
    ../security/yubikey.nix

    ../system/documentation.nix
    ../system/greetd.nix
    ../system/security.nix

    ../virtualisation/qemu.nix
  ];

  nix.settings.trusted-users = ["schwem"];

  # this is required to make home manager managed GTK items function
  programs.dconf.enable = true;

  services = {
    getty.autologinUser = "schwem";
    resolved.dnsovertls = lib.mkDefault "true";

    rclone = {
      enableFlareon = true;
      enableJolteon = true;
      enableTentacool = true;
      enableZapados = true;
    };

    tailscale.extraUpFlags = [
      "--advertise-tags tag:pc"
      "--exit-node=us-chi-wg-304.mullvad.ts.net"
      "--exit-node-allow-lan-access=true"
      "--operator=schwem"
    ];
  };

  systemd.services.tailscaled-autoconnect = let
    after = lib.mkDefault [
      "NetworkManager-wait-online"
    ];
    wants = after;
  in {
    inherit after wants;
  };

  time.timeZone = "America/New_York";
  users.mutableUsers = true; # allow mutable users on non-servers
}
