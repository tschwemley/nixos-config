{ pkgs, ... }:
{
  imports = [
    ../.

    ./binds.nix
    ./options.nix
    ./plugins.nix
    ./rules.nix
    # ./services
    ./settings.nix

    ../../../services/dunst.nix
  ];

  home = {
    sessionVariables = {
      GDK_SCALE = 2;
      XCURSOR_SIZE = 32;
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };

    packages = with pkgs; [
      grimblast
      hyprpicker
      pyprland
    ];
  };

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    # use the hyprland package & portal from the nixos module
    # package = null;
    # portalPackage = null;

    systemd = {
      variables = [ "--all" ];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
