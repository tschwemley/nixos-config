{pkgs, ...}: let
  hyprbars = let
    hyprland = pkgs.hyprland;
  in
    pkgs.stdenv.mkDerivation {
      pname = "hyprbars";
      version = "0.1";
      src = pkgs.fetchFromGitHub {
        owner = "hyprwm";
        repo = "hyprland-plugins";
        rev = "b5d0cfdff726676b8c6df564fdb1732558d6c25b";
        sha256 = "sha256-US7WfYWqMax+uEaRPpCOn8ib2pLYDLa5Fy8dIjWH0aM=";
      };
      sourceRoot = "source/hyprbars";

      inherit (hyprland) nativeBuildInputs;

      buildInputs = [hyprland] ++ hyprland.buildInputs;
    };
in {
  imports = [
    # ../programs/eww
    ../services/dunst.nix
  ];

  home.packages = with pkgs; [
    clipman
    grim # grab images
    hyprpaper # wallpaper
    hyprpicker #color picker
    slurp # select a region (used in conjunction w/ grim)
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      # unscale XWayland
      xwayland {
        force_zero_scaling = true
      }

      env = GDK_SCALE,2
      env = XCURSOR_SIZE,32
    '';

    plugins = [
      # "/nix/store/yhwdlzii9a29r92a6az579gx1mwa838k-hyprbars-0.1/lib/libhyprbars.so"
      # "/home/schwem/.config/hypr/hyprbar/lib/libhyprbars.so"
      hyprbars
    ];

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
        "$mod, p, exec, ${pkgs.rofi}/bin/rofi -show drun"
      ];

      env = [
        # toolkit-specific scale
        "GDK_SCALE,2"
        "XCURSOR_SIZE,32"
      ];

      exec-once = [
        "hyprpaper"
      ];

      monitor = [
        "HDMI-A-2,3840x2160,0x0,1"
        "DP-2,2560x2880@60,3840x0,1"
      ];

      workspace = [
        "HDMI-A-2,1"
        "HDMI-A-2,3"
        "HDMI-A-2,5"
        "HDMI-A-2,7"
        "HDMI-A-2,9"
        "DP-2,2"
        "DP-2,4"
        "DP-2,6"
        "DP-2,8"
        "DP-2,10"
      ];
    };

    systemdIntegration = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=/home/schwem/.config/hypr/dual-bg.jpg
    preload=/home/schwem/.config/hypr/lg-bg.jpg
    wallpaper=DP-2,/home/schwem/.config/hypr/dual-bg.jpg
    wallpaper=HDMI-A-2,/home/schwem/.config/hypr/lg-bg.jpg
  '';
}
