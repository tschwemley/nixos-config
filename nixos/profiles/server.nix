{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./.
    ../modules/services/fail2ban.nix
    ../modules/users/server.nix
  ];

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  # disable man pages on servers
  documentation.man.enable = false;

  services.getty.autologinUser = "root";

  # make sure every user config has a root_password setup in secrets
  sops = {
    secrets = {
      root_password = {
        mode = "0440";
        neededForUsers = true;
      };
    };
  };

  time.timeZone = lib.mkDefault "UTC";
}
