{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    protonup-qt

    # retroarch-full
    # sidequest

    # lutris
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
      extest.enable = true; # translate X11 input events to uinput events (e.g. for using Steam Input on Wayland)
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
      remotePlay.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

      gamescopeSession = {
        enable = true;

        # REF: https://github.com/ChimeraOS/gamescope-session#user-configuration
        env = {
          OUTPUT_CONNECTOR = "eDP-1,DP-1,DP-2-HDMI-A-1,HDMI-A-2";
        };
      };

      # remotePlay.openFirewall = true;
    };
  };
}
