{
  self,
  config,
  lib,
  ...
}:
{
  imports = [ self.inputs.dank-greeter.nixosModules.default ];

  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";
  };

  systemd.user.services.niri-flake-polkit.enable = lib.mkIf config.programs.niri.enable false;
}
