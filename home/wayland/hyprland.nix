{pkgs, ...}: {
  imports = [
    ../programs/eww
    ../services/dunst.nix
  ];

  home.packages = with pkgs; [
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      "/nix/store/yhwdlzii9a29r92a6az579gx1mwa838k-hyprbars-0.1/lib/libhyprbars.so"
    ];

    settings = {
      "$mod" = "SUPER";

      monitor = [
        "HDMI-A-2,3840x2160,0x0,1"
        "DP-2,2560x2880@60,3840x0,1"
      ];

      bind = [
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
      ];

      workspace = [
        # "name:start, monitor:DP-2, default: true"
        # "name:code, monitor:DP-2"
        # "name:start, monitor:HDMI-1, default: true"
        # "name:code, monitor:HDMI-1"
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
