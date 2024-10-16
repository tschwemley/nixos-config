{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ./.
    ./development.nix

    ../hardware/audio
    ../programs/chrysalis
    ../programs/gamemode.nix
    ../programs/hyprland.nix
    ../programs/kdeconnect.nix
    ../programs/man.nix
    ../programs/steam.nix
    ../programs/wine.nix
    ../programs/xdg.nix
    ../services/colord.nix
    ../services/dbus.nix
    ../services/gnome.nix
    ../services/upower.nix
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

  services = {
    getty.autologinUser = "schwem";
    tailscale.extraUpFlags = [ "--advertise-tags=tag:pc" ];
  };
}
