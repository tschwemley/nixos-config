{
  self,
  lib,
  ...
}: {
  imports = [
    self.inputs.nixos-hardware.nixosModules.common-pc
    self.inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./.

    ../development/embedded.nix

    ../hardware/audio
    ../hardware/flipperzero.nix

    ../programs/hyprland.nix
    ../programs/kdeconnect.nix
    ../programs/keyboards
    ../programs/lutris.nix
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
    ../system/man.nix
    ../system/security.nix

    ../virtualisation/qemu.nix

    ../../android
  ];

  nix.settings.trusted-users = ["schwem"];
  nixpkgs.overlays = with self.overlays; [
    # aseprite
    visidata
    zen-browser
  ];

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
      "--exit-node-allow-lan-access=true"
      "--exit-node=us-chi-wg-305.mullvad.ts.net"
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
