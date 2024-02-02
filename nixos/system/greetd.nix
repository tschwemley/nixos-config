{
  config,
  lib,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = lib.getExe config.programs.hyprland.package;
        user = "schwem";
      };

      terminal.vt = 1;
    };
  };
}
