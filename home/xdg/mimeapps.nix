let
  audioPlayer = [ "mpv" ];
  imageViewer = [ "mpv" ];
  videoPlayer = [ "mpv Media Player" ];

  xdgAssociations =
    type: program: list:
    builtins.listToAttrs (
      map (e: {
        name = "${type}/${e}";
        value = program;
      }) list
    );

  audio = xdgAssociations "audio" audioPlayer [
    "mp3"
    "flac"
    "wav"
    "aac"
  ];

  image = xdgAssociations "image" imageViewer [
    "png"
    "svg"
    "jpeg"
    "gif"
  ];

  video = xdgAssociations "video" videoPlayer [
    "mp4"
    "mpeg"
    "x-flv"
    "x-matroska"
    "x-ms-wmv"
    "x-msvideo"
  ];

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) (
    {
      "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf" ];
      "text/plain" = [ "nvim" ];
      "inode/directory" = [ "yazi" ];
    }
    // audio
    // image
    // video
  );
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = associations;
  };
}
