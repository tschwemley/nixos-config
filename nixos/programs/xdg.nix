{}
# {config, pkgs, ...}: {
#   xdg.portal = let
#     hyprland = config.wayland.windowManager.hyprland.package;
#     xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
#   in {
#     configPackages = [hyprland];
#     extraPortals = [xdph];
#     xdgOpenUsePortal = true;
#   };
#   # xdg.portal = {
#   #   enable = true;
#   #   xdgOpenUsePortal = true;
#   #   config = {
#   #     common.default = ["gtk"];
#   #     hyprland.default = ["gtk" "hyprland"];
#   #   };
#   #
#   #   extraPortals = [
#   #     pkgs.xdg-desktop-portal-gtk
#   #   ];
#   # };
# }
