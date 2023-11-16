{pkgs, ...}: {
  imports = [./hyprland.nix];

  environment.systemPackages = with pkgs; [
    ydotool
  ];
}
