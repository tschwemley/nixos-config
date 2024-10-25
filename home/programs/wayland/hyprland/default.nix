{ pkgs, ... }:
{
  imports = [
    ./binds.nix
    ./options.nix
    ./rules.nix
    ./settings.nix

    ./plugins

    # ../hyprlock.nix
    # TODO: add these imports or put into own module/wayland module
    # ../../../services/dunst.nix
    # ../../../services/hypridle.nix
    # ../../../services/hyprpaper.nix
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  home.packages = with pkgs; [
    grimblast
    hyprpicker
  ];

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
