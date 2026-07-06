{ pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;

    package =
      with pkgs.python3Packages;
      yt-dlp.overridePythonAttrs (prev: {
        dependencies = prev.dependencies ++ [ beautifulsoup4 ];
      });
  };

}
