# TODO: this should be renamed as a game module instead of steam
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    protonup-qt
    # retroarch-full
    # sidequest
  ];

  # Gamescope is the the SteamOS session compositing window manager. It runs on top of a desktop
  # in its own sandbox. Can spoof virtual screens with desired resolution to force certain
  # res/aspect ratios, handles upscaling, has been known to help with lag, etc.
  #
  # Official docs: https://github.com/ValveSoftware/gamescope
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    steam = {
      enable = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

      # translate X11 input events to uinput events (e.g. for using Steam Input on Wayland)
      # extest.enable = true;

      gamescopeSession = {
        enable = true;

        # REF: https://github.com/ChimeraOS/gamescope-session#user-configuration
        env = {
          OUTPUT_CONNECTOR = "eDP-1,DP-1,DP-2-HDMI-A-1,HDMI-A-2";
        };
      };

      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;

      # remotePlay.openFirewall = true;
    };
  };

  # services.monado = {
  #   enable = true;
  #   defaultRuntime = true; # Register as default OpenXR runtime
  # };
  #
  # systemd.user.services.monado.environment = {
  #   STEAMVR_LH_ENABLE = "1";
  #   XRT_COMPOSITOR_COMPUTE = "1";
  # };

  # ---
  # TODO: uncomment or delete, pending lutris config

  # enable esync compatability (for Lutris)

  # home-manager.users.schwem.systemd.user.settings.Manager.DefaultLimitNOFILE = "524288";
  # security = {
  #   pam = {
  #     loginLimits = [
  #       {
  #         domain = "schwem";
  #         item = "nofile";
  #         type = "hard";
  #         value = "524288";
  #       }
  #     ];
  #   };
  # };
  #
  # systemd.extraConfig = "DefaultLimitNOFILE=524288";
  # systemd.user.extraConfig = "DefaultLimitNOFILE=524288";
}
