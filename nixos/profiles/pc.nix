{
  self,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    self.inputs.nixos-hardware.nixosModules.common-pc
    self.inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./.

    ../development/embedded.nix

    ../hardware/audio
    ../hardware/flipperzero.nix
    ../hardware/xbox-controller.nix

    ../network/wireshark.nix

    ../programs/gaming.nix
    ../programs/hyprland.nix
    ../programs/kdeconnect.nix
    ../programs/keyboards
    ../programs/niri.nix
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
    # ../programs/flatpak.nix

    ../virtualisation/qemu.nix

    ../../android
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nix.settings.trusted-users = [ "schwem" ];

  # this is required to make home manager managed GTK items function
  programs.dconf.enable = true;

  services = {
    getty.autologinUser = "schwem";
    resolved.settings.Resolve.DNSOverTLS = lib.mkDefault "true";

    rclone = {
      # enableArticuno = true;
      enableFlareon = true;
      enableJolteon = true;
      enableTentacool = true;
      # enableZapdos = true;
    };

    # TODO: make the exit-node choose based on the fastest connection (tailscale exit-node suggest)
    # instead of being hard-coded
    tailscale.extraUpFlags = [
      "--advertise-tags tag:pc"
      "--exit-node-allow-lan-access=true"
      "--exit-node=us-chi-wg-308.mullvad.ts.net"
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
