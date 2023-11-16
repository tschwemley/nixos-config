{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../programs/eww
    ../services/dunst.nix
  ];

  wayland.windowManager.hyprland = let
    hyprlandPlugins = inputs.hyprland-plugins.packages.${pkgs.system};
  in {
    enable = true;
    plugins = [
      hyprlandPlugins.hyprbars
      # pkgs.waybar-hyprland
    ];
    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
      ];

      workspace = [
        "name:start, monitor:HDMI-1, default: true"
        "name:code, monitor:HDMI-1"
      ];
    };
    # extraConfig = ''
    #   $mod = SUPER
    #
    #   bind = $mod, T, exec, wezterm
    #   # bind = , Print, exec, grimblast copy area
    #
    #   # workspaces
    #   # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
    #   ${builtins.concatStringsSep "\n" (builtins.genList (
    #       x: let
    #         ws = let
    #           c = (x + 1) / 10;
    #         in
    #           builtins.toString (x + 1 - (c * 10));
    #       in ''
    #         bind = $mod, ${ws}, workspace, ${toString (x + 1)}
    #         bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
    #       ''
    #     )
    #     10)}
    # '';
  };
}
