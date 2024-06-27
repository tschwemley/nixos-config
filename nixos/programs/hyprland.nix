{pkgs, ...}: {
  programs.hyprland.enable = true;
  environment = {
    sessionVariables = {
      #WLR_NO_HARDWARE_CURSORS = "1"; # fixes invisible cursor in some instances (e.g. excalidraw brave)
      NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
    };

    # must-have for hyprland (https://wiki.hyprland.org/Useful-Utilities/Must-have/)
    systemPackages = with pkgs; [
      libsForQt5.qtwayland
      qt6.qtwayland
    ];
  };
}
