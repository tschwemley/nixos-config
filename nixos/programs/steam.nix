{
  # environment.systemPackages = with pkgs; [
  #   gamescope
  # ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
}
