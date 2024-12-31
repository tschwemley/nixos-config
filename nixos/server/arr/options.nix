{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options = {
    enableNzbHydra2 = mkEnableOption "NZBHydra2";
  };
}
