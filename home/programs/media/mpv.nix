{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;

    config = ''
      hwdec=auto-safe
      vo=gpu
      profile=gpu-hq
      gpu-context=wayland
    '';

    scripts =
      let
        imageViewer = with pkgs.mpvScripts.mpv-image-viewer; [
          detect-image
          equalizer
          freeze-window
          image-positioning
          minimap
          ruler
          status-line
        ];
      in
      [ ] ++ imageViewer;
  };
}

# REF: https://mpv.io/manual/master/
