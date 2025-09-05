let
  audioPlayer = [ "vlc" ];
  browser = [ "zen-beta" ];
  imageViewer = [ "org.gnome.Loupe" ];
  videoPlayer = [ "vlc" ];

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

  browserTypes =
    (xdgAssociations "application" browser [
      "json"
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
      "x-extension-xhtml+xml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "chrome"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);
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
      "text/html" = browser;
      "text/plain" = [ "nvim" ];
      "x-scheme-handler/chrome" = browser;
      "inode/directory" = [ "yazi" ];
    }
    // audio
    // browserTypes
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
