{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
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
