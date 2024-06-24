{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./hyprpaper.nix
    ./rules.nix
    ./settings.nix
    # TODO: add these imports or put into own module/wayland module
    # ../../../programs/ags
    # ../../../services/dunst.nix
  ];

  home.packages = with pkgs; [
    grimblast
    hyprpicker
  ];

  # make stuff work on wayland
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      # # unscale XWayland (this prevents lag in wezterm)
      # xwayland {
      #   force_zero_scaling = true
      # }
    '';

    # plugins = [
    #   pkgs.hypreasymotion
    #   # "/home/schwem/libhypreasymotion.so"
    #   # "/home/schwem/libhyprscroller.so"
    # ];

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
