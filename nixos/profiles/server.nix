{lib, ...}: {
  imports = [
    ./.
    ../network/systemd-networkd.nix
    ../services/fail2ban.nix
    ../virtualisation/podman.nix
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

  systemd.network.enable = true;
  time.timeZone = lib.mkDefault "UTC";
}
