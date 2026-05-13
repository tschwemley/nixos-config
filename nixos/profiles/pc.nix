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

    # TODO: uncomment me after fix for wrong hash merged upstream (within ~2 days of 05/04/2026)
    ../network/wireshark.nix

    ../programs/gaming.nix
    ../programs/kdeconnect.nix
    ../programs/keyboards
    ../programs/usbutils.nix
    ../programs/wine.nix

    ../services/colord.nix
    ../services/comfyui.nix
    ../services/dbus.nix
    ../services/gamemode.nix
    ../services/orca.nix
    ../services/printing.nix
    ../services/udisks2.nix

    ../security

    ../system/boot/systemd.nix
    ../system/documentation.nix
    ../system/man.nix

    ../theme

    ../virtualisation/qemu.nix

    ../wayland

    ../../android
  ];

  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;

  nix.settings.trusted-users = [ "schwem" ];
  nixpkgs.overlays = [ self.inputs.niri.overlays.niri ];

  # TODO: split both dconf and niri out from this file
  # this is required to make home manager managed GTK items function
  programs.dconf.enable = true;
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

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
