{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  brillo = lib.getExe pkgs.brillo;

  # timeout after which DPMS kicks in
  timeout = 300;
in {
  # screen idle
  services.hypridle = {
    enable = true;

    package = inputs.hypridle.packages.${pkgs.system}.hypridle;

    settings = {
      general = {
        lock_cmd = lib.getExe config.programs.hyprlock.package;
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
      };

      listener = [
        {
          timeout = timeout - 10;
          # save the current brightness and dim the screen over a period of
          # 1 second
          on-timeout = "${brillo} -O; ${brillo} -u 1000000 -S 10";
          # brighten the screen over a period of 500ms to the saved value
          on-resume = "${brillo} -I -u 500000";
        }
        {
          inherit timeout;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
