{
  self,
  lib,
  ...
}:
{
  imports = [
    self.inputs.nixos-hardware.nixosModules.common-pc
    self.inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./.

    # TODO: re-enable when noticing comment next... as of 2025-07-28 issues with build
    #
    # ../development/embedded.nix

    ../hardware/audio
    ../hardware/flipperzero.nix
    ../hardware/xbox-controller.nix

    ../network/wireshark.nix

    ../programs/hyprland.nix
    ../programs/kdeconnect.nix
    ../programs/keyboards
    ../programs/gaming.nix
    ../programs/usbutils.nix
    ../programs/wine.nix

    ../services/colord.nix
    ../services/dbus.nix
    ../services/gamemode.nix
    ../services/gnome.nix
    ../services/libinput.nix
    ../services/printing.nix
    ../services/upower.nix

    ../security

    ../system/documentation.nix
    ../system/greetd.nix
    ../system/man.nix

    # ../theme

    ../virtualisation/qemu.nix

    ../../android
  ];

  nix.settings.trusted-users = [ "schwem" ];

  # this is required to make home manager managed GTK items function
  programs.dconf.enable = true;

  services = {
    getty.autologinUser = "schwem";
    resolved.dnsovertls = lib.mkDefault "true";

    rclone = {
      enableFlareon = true;
      enableJolteon = true;
      enableTentacool = true;
      # enableZapdos = true;
    };

    tailscale.extraUpFlags = [
      "--advertise-tags tag:pc"
      "--exit-node-allow-lan-access=true"
      "--exit-node=us-chi-wg-305.mullvad.ts.net"
      "--operator=schwem"
    ];
  };

  systemd.services.tailscaled-autoconnect =
    let
      after = lib.mkDefault [
        "NetworkManager-wait-online.service"
      ];
      wants = after;
    in
    {
      inherit after wants;
    };

  time.timeZone = "America/New_York";
  users.mutableUsers = true; # allow mutable users on non-servers
}
