{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.stoat = {
    enable = lib.mkEnableOption "Enable stoat";
  };

  config = lib.mkIf config.stoat.enable {

    # Containers
    virtualisation.oci-containers.containers."stoat-api" = {
      image = "ghcr.io/stoatchat/api:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      dependsOn = [
        "stoat-database"
        "stoat-rabbit"
        "stoat-redis"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=api"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-api" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-database.service"
        "podman-stoat-rabbit.service"
        "podman-stoat-redis.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-autumn" = {
      image = "ghcr.io/stoatchat/file-server:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      dependsOn = [
        "stoat-createbuckets"
        "stoat-database"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=autumn"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-autumn" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-createbuckets.service"
        "podman-stoat-database.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-caddy" = {
      image = "docker.io/caddy";
      environment = {
        "HOSTNAME" = "https://localhost:8880";
        "REVOLT_PUBLIC_URL" = "https://localhost:8880/api";
        "VITE_API_URL" = "https://localhost:8880/api";
        "VITE_MEDIA_URL" = "https://localhost:8880/autumn";
        "VITE_PROXY_URL" = "https://localhost:8880/january";
        "VITE_WS_URL" = "wss://localhost:8880/ws";
      };
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Caddyfile:/etc/caddy/Caddyfile:rw"
        "/home/schwem/nixos-config/nixos/server/communication/stoat/data/caddy-config:/config:rw"
        "/home/schwem/nixos-config/nixos/server/communication/stoat/data/caddy-data:/data:rw"
      ];
      ports = [
        "80:80/tcp"
        "443:443/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=caddy"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-caddy" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-createbuckets" = {
      image = "docker.io/minio/mc";
      dependsOn = [
        "stoat-minio"
      ];
      log-driver = "journald";
      extraOptions = [
        "--entrypoint=[\"/bin/sh\", \"-c\", \" while ! /usr/bin/mc ready minio; do
      /usr/bin/mc alias set minio http://minio:9000 minioautumn minioautumn;
      echo 'Waiting minio...' && sleep 1;
    done; /usr/bin/mc mb minio/revolt-uploads; exit 0; \"]"
        "--network-alias=createbuckets"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-createbuckets" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "no";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-minio.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-crond" = {
      image = "ghcr.io/stoatchat/crond:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      dependsOn = [
        "stoat-database"
        "stoat-minio"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=crond"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-crond" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-database.service"
        "podman-stoat-minio.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-database" = {
      image = "docker.io/mongo";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/data/db:/data/db:rw"
      ];
      log-driver = "journald";
      extraOptions = [
        "--health-cmd=echo 'db.runCommand(\"ping\").ok' | mongosh localhost:27017/test --quiet"
        "--health-interval=10s"
        "--health-retries=5"
        "--health-start-period=10s"
        "--health-timeout=10s"
        "--network-alias=database"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-database" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-events" = {
      image = "ghcr.io/stoatchat/events:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      dependsOn = [
        "stoat-database"
        "stoat-redis"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=events"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-events" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-database.service"
        "podman-stoat-redis.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-gifbox" = {
      image = "ghcr.io/stoatchat/gifbox:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=gifbox"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-gifbox" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-january" = {
      image = "ghcr.io/stoatchat/proxy:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=january"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-january" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-livekit" = {
      image = "ghcr.io/stoatchat/livekit-server:v1.9.6";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/livekit.yml:/etc/livekit.yml:rw"
      ];
      ports = [
        "7881:7881/tcp"
        "50000:50000/udp"
        "50001:50001/udp"
        "50002:50002/udp"
        "50003:50003/udp"
        "50004:50004/udp"
        "50005:50005/udp"
        "50006:50006/udp"
        "50007:50007/udp"
        "50008:50008/udp"
        "50009:50009/udp"
        "50010:50010/udp"
        "50011:50011/udp"
        "50012:50012/udp"
        "50013:50013/udp"
        "50014:50014/udp"
        "50015:50015/udp"
        "50016:50016/udp"
        "50017:50017/udp"
        "50018:50018/udp"
        "50019:50019/udp"
        "50020:50020/udp"
        "50021:50021/udp"
        "50022:50022/udp"
        "50023:50023/udp"
        "50024:50024/udp"
        "50025:50025/udp"
        "50026:50026/udp"
        "50027:50027/udp"
        "50028:50028/udp"
        "50029:50029/udp"
        "50030:50030/udp"
        "50031:50031/udp"
        "50032:50032/udp"
        "50033:50033/udp"
        "50034:50034/udp"
        "50035:50035/udp"
        "50036:50036/udp"
        "50037:50037/udp"
        "50038:50038/udp"
        "50039:50039/udp"
        "50040:50040/udp"
        "50041:50041/udp"
        "50042:50042/udp"
        "50043:50043/udp"
        "50044:50044/udp"
        "50045:50045/udp"
        "50046:50046/udp"
        "50047:50047/udp"
        "50048:50048/udp"
        "50049:50049/udp"
        "50050:50050/udp"
        "50051:50051/udp"
        "50052:50052/udp"
        "50053:50053/udp"
        "50054:50054/udp"
        "50055:50055/udp"
        "50056:50056/udp"
        "50057:50057/udp"
        "50058:50058/udp"
        "50059:50059/udp"
        "50060:50060/udp"
        "50061:50061/udp"
        "50062:50062/udp"
        "50063:50063/udp"
        "50064:50064/udp"
        "50065:50065/udp"
        "50066:50066/udp"
        "50067:50067/udp"
        "50068:50068/udp"
        "50069:50069/udp"
        "50070:50070/udp"
        "50071:50071/udp"
        "50072:50072/udp"
        "50073:50073/udp"
        "50074:50074/udp"
        "50075:50075/udp"
        "50076:50076/udp"
        "50077:50077/udp"
        "50078:50078/udp"
        "50079:50079/udp"
        "50080:50080/udp"
        "50081:50081/udp"
        "50082:50082/udp"
        "50083:50083/udp"
        "50084:50084/udp"
        "50085:50085/udp"
        "50086:50086/udp"
        "50087:50087/udp"
        "50088:50088/udp"
        "50089:50089/udp"
        "50090:50090/udp"
        "50091:50091/udp"
        "50092:50092/udp"
        "50093:50093/udp"
        "50094:50094/udp"
        "50095:50095/udp"
        "50096:50096/udp"
        "50097:50097/udp"
        "50098:50098/udp"
        "50099:50099/udp"
        "50100:50100/udp"
      ];
      cmd = [
        "--config"
        "/etc/livekit.yml"
      ];
      dependsOn = [
        "stoat-redis"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=livekit"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-livekit" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-redis.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-minio" = {
      image = "docker.io/minio/minio";
      environment = {
        "MINIO_DOMAIN" = "minio";
        "MINIO_ROOT_PASSWORD" = "minioautumn";
        "MINIO_ROOT_USER" = "minioautumn";
      };
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/data/minio:/data:rw"
      ];
      cmd = [
        "server"
        "/data"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=minio"
        "--network=stoat_default:alias=revolt-uploads.minio,alias=attachments.minio,alias=avatars.minio,alias=backgrounds.minio,alias=icons.minio,alias=banners.minio,alias=emojis.minio"
      ];
    };
    systemd.services."podman-stoat-minio" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-pushd" = {
      image = "ghcr.io/stoatchat/pushd:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      dependsOn = [
        "stoat-database"
        "stoat-rabbit"
        "stoat-redis"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=pushd"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-pushd" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-database.service"
        "podman-stoat-rabbit.service"
        "podman-stoat-redis.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-rabbit" = {
      image = "docker.io/rabbitmq:4";
      environment = {
        "RABBITMQ_DEFAULT_PASS" = "rabbitpass";
        "RABBITMQ_DEFAULT_USER" = "rabbituser";
      };
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/data/rabbit:/var/lib/rabbitmq:rw"
      ];
      log-driver = "journald";
      extraOptions = [
        "--health-cmd=rabbitmq-diagnostics -q ping"
        "--health-interval=10s"
        "--health-retries=3"
        "--health-start-period=20s"
        "--health-timeout=10s"
        "--network-alias=rabbit"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-rabbit" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-redis" = {
      image = "docker.io/eqalpha/keydb";
      log-driver = "journald";
      extraOptions = [
        "--network-alias=redis"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-redis" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-voice-ingress" = {
      image = "ghcr.io/stoatchat/voice-ingress:v0.11.1";
      volumes = [
        "/home/schwem/nixos-config/nixos/server/communication/stoat/Revolt.toml:/Revolt.toml:rw"
      ];
      dependsOn = [
        "stoat-database"
        "stoat-rabbit"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=voice-ingress"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-voice-ingress" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
        "podman-stoat-database.service"
        "podman-stoat-rabbit.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };
    virtualisation.oci-containers.containers."stoat-web" = {
      image = "ghcr.io/stoatchat/for-web:addb6b7";
      environment = {
        "HOSTNAME" = "https://localhost:8880";
        "REVOLT_PUBLIC_URL" = "https://localhost:8880/api";
        "VITE_API_URL" = "https://localhost:8880/api";
        "VITE_MEDIA_URL" = "https://localhost:8880/autumn";
        "VITE_PROXY_URL" = "https://localhost:8880/january";
        "VITE_WS_URL" = "wss://localhost:8880/ws";
      };
      log-driver = "journald";
      extraOptions = [
        "--network-alias=web"
        "--network=stoat_default"
      ];
    };
    systemd.services."podman-stoat-web" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-stoat_default.service"
      ];
      requires = [
        "podman-network-stoat_default.service"
      ];
      partOf = [
        "podman-compose-stoat-root.target"
      ];
      upheldBy = [
        "podman-network-stoat_default.service"
      ];
      wantedBy = [
        "podman-compose-stoat-root.target"
      ];
    };

    # Networks
    systemd.services."podman-network-stoat_default" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f stoat_default";
      };
      script = ''
        podman network inspect stoat_default || podman network create stoat_default
      '';
      partOf = [ "podman-compose-stoat-root.target" ];
      wantedBy = [ "podman-compose-stoat-root.target" ];
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    systemd.targets."podman-compose-stoat-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
