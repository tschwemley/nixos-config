{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
    };

    # must-have for hyprland (https://wiki.hyprland.org/Useful-Utilities/Must-have/)
    systemPackages = with pkgs; [
      libsForQt5.qtwayland
      qt6.qtwayland
    ];
  };
}
