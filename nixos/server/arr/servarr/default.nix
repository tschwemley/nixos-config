{
  config,
  lib,
  ...
}: let
  cfg = config.services.servarr;

  inherit (lib) mkEnableOption;
in {
  options.services.servarr = {
    enableRadarr = mkEnableOption "Radarr";
    enableSonarr = mkEnableOption "Sonarr";
    enableWhisparr = mkEnableOption "Whisparr";
  };

  config = {
    services = {
      sonarr.enable = cfg.enableSonarr;
      whisparr.enable = cfg.enableWhisparr;
    };
  };
}
