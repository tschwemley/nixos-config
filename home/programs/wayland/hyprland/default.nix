{pkgs, ...}: {
  imports = [
    ../.
    ./binds.nix
    ./options.nix
    ./plugins.nix
    ./rules.nix
    ./services
    ./settings.nix

    # TODO: remove or add back if keeping dunst
    ../../../services/dunst.nix
  ];

  home.sessionVariables = {
    GDK_SCALE = 2;
    XCURSOR_SIZE = 32;
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  home.packages = with pkgs; [
    grimblast # TODO: are grimblast and grim both needed?
    hyprcursor
    hyprpicker
  ];

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    # use the hyprland package from the nixos module
    package = null;
    portalPackage = null;

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
