# Auto-generated using compose2nix v0.3.1.
{
  config,
  pkgs,
  lib,
  ...
}: let
  stateDir = "/var/lib/sillytavern";
in {
  virtualisation = {
    oci-containers.backend = "podman";

    # Containers
    oci-containers.containers."sillytavern" = {
      image = "localhost/ghcr.io/sillytavern/sillytavern:latest";
      environment = {
        "FORCE_COLOR" = "1";
        "NODE_ENV" = "production";
      };
      volumes = [
        "${stateDir}/config:/home/node/app/config:rw"
        "${stateDir}/data:/home/node/app/data:rw"
        "${stateDir}/extensions:/home/node/app/public/scripts/extensions/third-party:rw"
        "${stateDir}/plugins:/home/node/app/plugins:rw"
      ];
      ports = [
        "127.0.0.1:${config.variables.ports.silly-tavern}:8000/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--hostname=sillytavern"
        "--network-alias=sillytavern"
        "--network=sillytavern_default"
      ];
    };
  };

  systemd = let
    service = ["podman-network-sillytavern_default.service"];
    target = ["podman-compose-sillytavern-root.target"];
  in {
    serviceConfig.Restart = lib.mkOverride 90 "always";
    after = service;
    requires = service;
    partOf = target;
    wantedBy = target;
  };

  services = {
    # Builds
    "podman-build-sillytavern" = {
      path = [pkgs.podman pkgs.git];
      serviceConfig = {
        Type = "oneshot";
        TimeoutSec = 300;
      };
      script = ''
        cd /home/schwem/nixos-config
        podman build -t ghcr.io/sillytavern/sillytavern:latest .
      '';
    };

    # Networks
    "podman-network-sillytavern_default" = {
      path = [pkgs.podman];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f sillytavern_default";
      };
      script = ''
        podman network inspect sillytavern_default || podman network create sillytavern_default
      '';
      partOf = ["podman-compose-sillytavern-root.target"];
      wantedBy = ["podman-compose-sillytavern-root.target"];
    };

    tmpfiles.rules = [
      "d ${stateDir}/config 0750 root users - -"
      "d ${stateDir}/data 0750 root users - -"
      "d ${stateDir}/extensions 0750 root users - -"
      "d ${stateDir}/plugins 0750 root users - -"
    ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  targets."podman-compose-sillytavern-root" = {
    unitConfig = {
      Description = "Root target for sillytavern container";
    };
    wantedBy = ["multi-user.target"];
  };
}
