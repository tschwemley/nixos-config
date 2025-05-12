{
  programs.tealdeer = {
    enable = true;

    # REF: https://tealdeer-rs.github.io/tealdeer/config.html
    settings = {
      directories.custom_pages_dir = ./cheatsheets;
    };
  };
}
