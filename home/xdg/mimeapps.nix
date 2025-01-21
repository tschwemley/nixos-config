let
  browser = ["zen"];
  # imageViewer = ["org.gnome.Loupe"];
  # audioPlayer = ["io.bassi.Amberol"];

  xdgAssociations = type: program: list:
    builtins.listToAttrs (
      map (e: {
        name = "${type}/${e}";
        value = program;
      })
      list
    );

  # image = xdgAssociations "image" imageViewer ["png" "svg" "jpeg" "gif"];
  video = xdgAssociations "video" ["vlc"] ["avi" "mp4" "mkv" "wmv"];
  # audio = xdgAssociations "audio" audioPlayer ["mp3" "flac" "wav" "aac"];
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

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) (
    {
      # "application/pdf" = ["org.pwmt.zathura-pdf-mupdf"];
      "text/html" = browser;
      "text/plain" = ["nvim"];
      "x-scheme-handler/chrome" = browser;
      # "inode/directory" = ["yazi"];
      "inode/directory" = ["nemo"];
    }
    # // audio
    # // image
    // video
    // browserTypes
  );
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = associations;
  };
}
