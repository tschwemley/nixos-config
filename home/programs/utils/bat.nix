{
  # when using bat also use it as the man pager
  home = {
    sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };

    shellAliases = {
      bath = "bat -pl makefile";
      batf = "tail -f | bat -pl";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
    };
  };
}
