{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./.
    ../network/containers.nix
    ../network/systemd-networkd.nix
    ../network/tailscale.nix
    ../server/monitoring/prometheus/node-exporter.nix
    ../server/nginx
    ../services/fail2ban.nix
  ];

  # disable man pages on servers
  documentation.man.enable = false;

  environment.systemPackages = with pkgs; [postgresql_16];

  services.getty.autologinUser = "root";

  # make sure every user config has a root_password setup in secrets
  sops = {
    age.keyFile = "/root/.config/sops/age/keys.txt";

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
