{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  environment.systemPackages = with pkgs; [
    nautilus
    xwayland-satellite
  ];
}
