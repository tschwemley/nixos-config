{
  home.shellAliases.batf = "tail -f | bat -pl";

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
    };
  };
}
