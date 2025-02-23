# TODO: this should be renamed as a game module instead of steam
{pkgs, ...}: {
  # Gamescope is the the SteamOS session compositing window manager. It runs on top of a desktop
  # in its own sandbox. Can spoof virtual screens with desired resolution to force certain 
  # res/aspect ratios, handles upscaling, has been known to help with lag, etc.
  #
  # Official docs: https://github.com/ValveSoftware/gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true; # NOTE: this may break steam overlay (it used to - not sure if fixed by now)
    args = [
      "--rt"
      "--expose-wayland"
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;

    # gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sidequest
  ];
}
