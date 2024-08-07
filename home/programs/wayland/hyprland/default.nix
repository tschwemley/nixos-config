{
  inputs, 
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
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

  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    extraPortals = [xdph];
    configPackages = [hyprland];
  };

}
