{ self, pkgs, ... }:
{
  imports = [
    self.inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [ self.inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  services.dbus.packages = [ pkgs.nautilus ];

  # environment.systemPackages = with pkgs; [
  #   nautilus
  #   xwayland-satellite
  # ];
}
