{ self, pkgs, ... }:
{
  imports = [
    # ./services/hypridle.nix
    # ./services/hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    plugins = with pkgs.hyprlandPlugins; [
      hyprscrolling

      # self.inputs.hyprland-easymotion.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-easymotion

      # adds dispatchers: bringallfrom, closeunfocused, moveorexec, throwunfocused
      xtra-dispatchers

      # hy3
      # hyprscroller
    ];

    settings.plugin = {
      # hy3 = {
      #   autotile = {
      #     enable = true;
      #     # trigger_width = 800;
      #     # trigger_height = 500;
      #   };
      # };
    };
  };
}
