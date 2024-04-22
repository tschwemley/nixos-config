{
  inputs,
  pkgs,
  ...
}: {
  # ../../../programs/ags
  # ../../../services/dunst.nix
  imports = [
    ./binds.nix
    ./hyprpaper.nix
    ./rules.nix
    ./settings.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    hyprpicker
  ];

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      # unscale XWayland (this prevents lag in wezterm)
      xwayland {
        force_zero_scaling = true
      }
    '';

    plugins = [];

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
