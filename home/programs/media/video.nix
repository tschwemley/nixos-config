{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    # ffmpeg
    # handbrake
    # mediainfo
    # shotcut
    # vlc TODO: figure out why vlc is crashing
  ];

  # xdg.configFile."mpv/mpv.conf".text = ''
  #   gpu-context=wayland ; On wayland only
  #   hwdec=auto-safe
  #   profile=gpu-hq
  #   vo=gpu
  # '';
}
