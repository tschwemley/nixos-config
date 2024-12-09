{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  brillo = lib.getExe pkgs.brillo;

  # timeout after which DPMS kicks in
  dpmsTimeout = 1800;
in {
  # screen idle
  services.hypridle = {
    enable = true;

    package = inputs.hypridle.packages.${pkgs.system}.hypridle;

    settings = {
      general = {
        lock_cmd = lib.getExe config.programs.hyprlock.package;
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";

        # to avoid having to press a key twice to turn on the display.
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # 10 seconds before display turns off save current prightness and dim the screen
        {
          timeout = dpmsTimeout - 10;
          # save the current brightness and dim the screen over a period of
          # 1 second
          on-timeout = "${brillo} -O; ${brillo} -u 1000000 -S 10";
          # brighten the screen over a period of 500ms to the saved value
          on-resume = "${brillo} -I -u 500000";
        }
        # turn off display
        {
          timeout = dpmsTimeout;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
