# Auto-generated using compose2nix v0.2.2.
{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.nginx.virtualHosts."twitch.schwem.io".locations = {
    "/api" = {
      proxyPass = "http://127.0.0.1:${config.portMap.safetwitch-backend}";
      proxyWebsockets = true;
    };
    "/" = {
      proxyPass = "http://127.0.0.1:${config.portMap.safetwitch-frontend}";
      proxyWebsockets = true;
    };
  };

  # Containers
  virtualisation.oci-containers.containers = {
    "safetwitch-frontend" = {
      image = "codeberg.org/safetwitch/safetwitch:latest";
      environment = {
        "SAFETWITCH_BACKEND_DOMAIN" = "twitch.schwem.io";
        "SAFETWITCH_DEFAULT_LOCALE" = "en";
        "SAFETWITCH_FALLBACK_LOCALE" = "en";
        "SAFETWITCH_HTTPS" = "true";
        "SAFETWITCH_INSTANCE_DOMAIN" = "twitch.schwem.io";
      };
      ports = [
        "127.0.0.1:${config.portMap.safetwitch-frontend}:8280/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--cap-add=CHOWN"
        "--cap-add=SETGID"
        "--cap-add=SETUID"
        "--cap-drop=ALL"
        "--hostname=safetwitch-frontend"
        "--network-alias=safetwitch-frontend"
        "--network=safetwitch_default"
        "--security-opt=no-new-privileges:true"
      ];
    };

    "safetwitch-backend" = {
      image = "codeberg.org/safetwitch/safetwitch-backend:latest";
      environment = {
        "PORT" = "7000";
        "URL" = "https://twitch.schwem.io";
      };
      ports = [
        "127.0.0.1:${config.portMap.safetwitch-backend}:7000/tcp"
      ];
      user = "65534:65534";
      log-driver = "journald";
      extraOptions = [
        "--cap-drop=ALL"
        "--hostname=safetwitch-backend"
        "--network-alias=safetwitch-backend"
        "--network=safetwitch_default"
        "--security-opt=no-new-privileges:true"
      ];
    };
  };

  systemd.services = {
    "podman-safetwitch-backend" = {
      serviceConfig = {
        Restart = lib.mkOverride 500 "always";
      };
      after = [
        "podman-network-safetwitch_default.service"
      ];
      requires = [
        "podman-network-safetwitch_default.service"
      ];
      partOf = [
        "podman-compose-safetwitch-root.target"
      ];
      wantedBy = [
        "podman-compose-safetwitch-root.target"
      ];
    };

    "podman-safetwitch-frontend" = {
      serviceConfig = {
        Restart = lib.mkOverride 500 "always";
      };
      after = [
        "podman-network-safetwitch_default.service"
      ];
      requires = [
        "podman-network-safetwitch_default.service"
      ];
      partOf = [
        "podman-compose-safetwitch-root.target"
      ];
      wantedBy = [
        "podman-compose-safetwitch-root.target"
      ];
    };

    # Networks
    "podman-network-safetwitch_default" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f safetwitch_default";
      };
      script = ''
        podman network inspect safetwitch_default || podman network create safetwitch_default
      '';
      partOf = [ "podman-compose-safetwitch-root.target" ];
      wantedBy = [ "podman-compose-safetwitch-root.target" ];
    };
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-safetwitch-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
