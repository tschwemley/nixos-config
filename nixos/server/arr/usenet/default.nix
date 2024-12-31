{
  # options = let
  #   inherit (lib.options) mkEnableOption;
  # in {
  #   enableNzbHydra2 = mkEnableOption "NZBHydra2";
  #   enableSabnzbd = mkEnableOption "SABNzbd";
  # };
  imports = [
    ./nzbhydra2.nix
    ./sabnzbd
  ];
}
