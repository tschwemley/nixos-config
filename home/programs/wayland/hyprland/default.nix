{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./hyprpaper.nix
    ./rules.nix
    ./settings.nix
    # TODO: add these imports or put into own module/wayland module
    # ../../../services/dunst.nix
  ];

  home.packages = with pkgs; [
    grimblast
    hyprpicker
  ];

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.default;

    # plugins = [
    #   pkgs.hypreasymotion
    #   # "/home/schwem/libhypreasymotion.so"
    #   # "/home/schwem/libhyprscroller.so"
    # ];

    systemd = {
      variables = ["--all"];
      extraCommands = [ # TODO: Idk if I actually need this...
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
