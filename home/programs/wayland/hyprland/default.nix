{
  config,
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
    grimblast
    hyprpicker
  ];

  xdg.portal = let
    hyprland = config.wayland.windowManager.hyprland.package;
    xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
  in {
    configPackages = [hyprland];
    extraPortals = [xdph pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
  };

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
