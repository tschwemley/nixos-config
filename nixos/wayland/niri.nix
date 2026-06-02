{ self, pkgs, ... }:
{
  imports = [
    self.inputs.niri.nixosModules.niri
  ];

  nix.settings = {
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
  };

  nixpkgs.overlays = [ self.inputs.niri.overlays.niri ];
  programs.niri.enable = true;
  services.dbus.packages = [ pkgs.nautilus ];

  # environment.systemPackages = with pkgs; [
  #   nautilus
  #   xwayland-satellite
  # ];
}
