{pkgs, ...}: {
  # when using bat also use it as the man pager
  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };

  programs.bat = {
    enable = true;
    config = {
      # lessopen = true;
      theme = "gruvbox-dark";
    };
    extraPackages = with pkgs; [
      # BUG: commented out due to compilation issues resulting from rust bug upstream (also affecting wezterm)
      # bat-extras.batdiff
      bat-extras.batpipe
      bat-extras.batwatch
    ];
  };
}
