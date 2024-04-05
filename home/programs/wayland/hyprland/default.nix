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
    ./hyprpaper.nix
    ./rules.nix
    ./settings.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    clipman
    hyprpicker
  ];

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''

      # plugin {
      #   split-monitor-workspaces {
      #       count = 5
      #   }
      # }

      # unscale XWayland (this prevents lag in wezterm)
      xwayland {
        force_zero_scaling = true
      }
    '';

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
}
