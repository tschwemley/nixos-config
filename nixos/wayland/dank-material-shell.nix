{
  self,
  config,
  lib,
  ...
}:
{
  imports = [ self.inputs.dms.nixosModules.greeter ];

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
  };

  systemd.user.services.niri-flake-polkit.enable = lib.mkIf config.programs.niri.enable false;
}
