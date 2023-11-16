{pkgs, ...}: {
  imports = [./hyprland.nix];

  environment.systemPackages = with pkgs; [
    qt6.qtwayland
    ydotool
    wtype
  ];
}
