{
  inputs,
  pkgs,
  ...
}:
#let
# inherit (inputs.split-monitor-workspaces.packages.${pkgs.system}) split-monitor-workspaces;
#in {
{
  # ../../../programs/ags
  # ../../../services/dunst.nix
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    # clipman
    # grim # grab images
    # grimblast # grab images
    hyprpaper # wallpaper
    hyprpicker #color picker

    # hyprshot #screenshot
    # slurp # select a region (used in conjunction w/ grim)
  ];

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    # extraConfig = ''
    #
    #   # plugin {
    #   #   split-monitor-workspaces {
    #   #       count = 5
    #   #   }
    #   # }
    #
    #   # unscale XWayland
    #   # xwayland {
    #   #   force_zero_scaling = true
    #   # }
    # '';

    plugins = [
      # split-monitor-workspaces
    ];

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=/home/schwem/.config/hypr/dual-bg.jpg
    preload=/home/schwem/.config/hypr/lg-bg.jpg
    wallpaper=DP-2,/home/schwem/.config/hypr/dual-bg.jpg
    wallpaper=HDMI-A-2,/home/schwem/.config/hypr/lg-bg.jpg
  '';
}
