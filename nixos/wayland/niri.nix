{ self, pkgs, ... }:
{
  imports = [
    self.inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [ self.inputs.niri.overlays.niri ];

  # this is required to make home manager managed GTK items function
  # TODO: this may not be required as it might already be included in the niri module
  programs.dconf.enable = true;

  services.dbus.packages = [ pkgs.nautilus ];

  environment.systemPackages = with pkgs; [
    nautilus
    xwayland-satellite
  ];

  # Enabling the niri modules via nixos will also import the home-manager module for niri.
  # In addition it handles setting some settings for us like enabling dconf, installing the
  # gnome xdg portal for screencasting, setting polkit, setting display manager session packages,
  # and a few more
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
