{
  self,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./.

    ../network/containers.nix
    ../network/systemd-networkd.nix
    ../network/tailscale.nix

    ../server/infrastructure/haproxy/options.nix
    ../server/infrastructure/monitoring/prometheus/node-exporter.nix
    ../server/infrastructure/nginx
    ../server/security/auth/oidcproxy

    # self.inputs.nix-topology.nixosModules.default
  ];

  # disable man pages on servers
  documentation.man.enable = false;

  environment.systemPackages = with pkgs; [
    postgresql_16
    sqlite-interactive
  ];

  services.getty.autologinUser = "root";

  sops.secrets = {
    "git.schwem.io.deploy.key" = {
      sopsFile = "${self.lib.secrets.nixos}/ssh.yaml";
      mode = "0600";
    };

    root_password = {
      mode = "0440";
      neededForUsers = true;
    };
  };

  time.timeZone = lib.mkDefault "UTC";
}
