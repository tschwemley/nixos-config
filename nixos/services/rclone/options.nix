{ lib, ... }:
{
  options =
    let
      inherit (lib) mkEnableOption;
    in
    {
      services.rclone = {
        enableFlareon = mkEnableOption "flareon";
        enableJolteon = mkEnableOption "jolteon";
        enableTentacool = mkEnableOption "tentacool";
        enablezapdos = mkEnableOption "zazpados";
      };
    };
}
