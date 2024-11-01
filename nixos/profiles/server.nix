{
  config,
  lib,
  pkgs,
  ...
}: let
  tmpImport =
    if config.networking.hostName != "moltres"
    then []
    else [];
in {
  imports =
    [
      ./.

      ../network/containers.nix
      ../network/systemd-networkd.nix
      ../network/tailscale.nix

      ../server/infrastructure/haproxy/options.nix
      ../server/infrastructure/monitoring/prometheus/node-exporter.nix
      ../server/infrastructure/nginx
      ../server/infrastructure/port-map.nix
      # ../server/security/auth/oidcsso
    ]
    ++ tmpImport;

  # disable man pages on servers
  documentation.man.enable = false;

  environment.systemPackages = with pkgs; [postgresql_16];

  services.getty.autologinUser = "root";

  sops = {
    age.keyFile = "/etc/sops/age-keys.txt";

    secrets = {
      container_deploy_key = {
        sopsFile = ../../containers/secrets.yaml;
        path = "/root/.ssh/container_deploy_key";
      };
      root_password = {
        mode = "0440";
        neededForUsers = true;
      };
    };
  };

  time.timeZone = lib.mkDefault "UTC";
}
