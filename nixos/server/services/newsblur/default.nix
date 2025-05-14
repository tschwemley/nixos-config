# Auto-generated using compose2nix v0.3.1.
{
  config,
  lib,
  pkgs,
  ...
}: {
  services.nginx.virtualHosts."schwem.io".locations."/".proxyPass = "http://127.0.0.1:${config.variables.ports.newsblur}";

  systemd = {
    services = {
      "podman-db_elasticsearch" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-db_mongo" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-db_postgres" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-db_redis" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-dejavu" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-haproxy" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-imageproxy" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-newsblur_web" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-nginx" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-node" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };
      "podman-task_celery" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-newsblur_default.service"
        ];
        requires = [
          "podman-network-newsblur_default.service"
        ];
        partOf = [
          "podman-compose-newsblur-root.target"
        ];
        wantedBy = [
          "podman-compose-newsblur-root.target"
        ];
      };

      # Networks
      "podman-network-newsblur_default" = {
        path = [pkgs.podman];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = "podman network rm -f newsblur_default";
        };
        script = ''
          podman network inspect newsblur_default || podman network create newsblur_default
        '';
        partOf = ["podman-compose-newsblur-root.target"];
        wantedBy = ["podman-compose-newsblur-root.target"];
      };
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    targets."podman-compose-newsblur-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = ["multi-user.target"];
    };
  };

  virtualisation = {
    oci-containers.containers = {
      "db_elasticsearch" = {
        image = "docker.elastic.co/elasticsearch/elasticsearch:8.17.0";
        environment = {
          "CLI_JAVA_OPTS" = "-XX:UseSVE=0";
          "ES_JAVA_OPTS" = "-XX:UseSVE=0";
          "cluster.routing.allocation.disk.threshold_enabled" = "false";
          "discovery.type" = "single-node";
          "xpack.security.enabled" = "false";
        };
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/config/elasticsearch/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml:rw"
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/volumes/elasticsearch:/usr/share/elasticsearch/data:rw"
        ];
        ports = [
          "9200:9200/tcp"
          "9300:9300/tcp"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=db_elasticsearch"
          "--network=newsblur_default"
        ];
      };
      "db_mongo" = {
        image = "mongo:4.0";
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/volumes/db_mongo:/data/db:rw"
        ];
        ports = [
          "29019:29019/tcp"
        ];
        cmd = ["mongod" "--port" "29019"];
        user = ":";
        log-driver = "journald";
        extraOptions = [
          "--network-alias=db_mongo"
          "--network=newsblur_default"
        ];
      };
      "db_postgres" = {
        image = "postgres:13.1";
        environment = {
          "POSTGRES_PASSWORD" = "newsblur";
          "POSTGRES_USER" = "newsblur";
        };
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/volumes/postgres:/var/lib/postgresql/data:rw"
        ];
        ports = [
          "5434:5432/tcp"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=db_postgres"
          "--network=newsblur_default"
        ];
      };
      "db_redis" = {
        image = "redis:latest";
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/redis/redis.conf:/etc/redis/redis.conf:rw"
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/redis/redis_server.conf:/usr/local/etc/redis/redis_replica.conf:rw"
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/volumes/redis:/data:rw"
        ];
        ports = [
          "6579:6579/tcp"
        ];
        cmd = ["redis-server" "/etc/redis/redis.conf" "--port" "6579"];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=db_redis"
          "--network=newsblur_default"
        ];
      };
      "dejavu" = {
        image = "appbaseio/dejavu:3.6.0";
        ports = [
          "1358:1358/tcp"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=dejavu"
          "--network=newsblur_default"
        ];
      };
      "haproxy" = {
        image = "haproxy:latest";
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur:/srv/newsblur:rw"
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/haproxy/haproxy.docker-compose.cfg:/usr/local/etc/haproxy/haproxy.cfg:rw"
        ];
        ports = [
          "80:80/tcp"
          "443:443/tcp"
          "1936:1936/tcp"
        ];
        dependsOn = [
          "db_elasticsearch"
          "db_mongo"
          "db_postgres"
          "db_redis"
          "imageproxy"
          "newsblur_web"
          "nginx"
          "node"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=haproxy"
          "--network=newsblur_default"
        ];
      };
      "imageproxy" = {
        image = "yusukeito/imageproxy:v0.11.2";
        volumes = [
          # "/tmp:/tmp/imageproxy:rw"
        ];
        ports = [
          "8088:8088/tcp"
        ];
        user = ":";
        log-driver = "journald";
        extraOptions = [
          "--entrypoint=[\"/app/imageproxy\", \"-addr\", \"0.0.0.0:8088\", \"-cache\", \"/tmp/imageproxy\", \"-verbose\"]"
          "--network-alias=imageproxy"
          "--network=newsblur_default"
        ];
      };
      "newsblur_web" = {
        image = "newsblur/newsblur_python3:latest";
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur:/srv/newsblur:rw"
        ];
        ports = [
          "${config.variables.ports.newsblur}:8000/tcp"
        ];
        dependsOn = [
          "db_elasticsearch"
          "db_mongo"
          "db_postgres"
          "db_redis"
        ];
        log-driver = "journald";
        extraOptions = [
          "--entrypoint=[\"/bin/sh\", \"-c\", \"newsblur_web/entrypoint.sh\"]"
          "--hostname=nb.com"
          "--network-alias=newsblur_web"
          "--network=newsblur_default"
        ];
      };
      "nginx" = {
        image = "nginx:1.19.6";
        environment = {
          "DOCKERBUILD" = "True";
        };
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur:/srv/newsblur:rw"
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/docker/nginx/nginx.local.conf:/etc/nginx/conf.d/nginx.conf:rw"
        ];
        ports = [
          "81:81/tcp"
        ];
        dependsOn = [
          "db_elasticsearch"
          "db_mongo"
          "db_postgres"
          "db_redis"
          "newsblur_web"
          "node"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=nginx"
          "--network=newsblur_default"
        ];
      };
      "node" = {
        image = "newsblur/newsblur_node:latest";
        environment = {
          "MONGODB_PORT" = "29019";
          "NODE_ENV" = "docker";
        };
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/node:/srv:rw"
          # "/home/schwem/nixos-config/nixos/server/services/newsblur/node/originals:/srv/originals:rw"
        ];
        ports = [
          "8008:8008/tcp"
        ];
        cmd = ["node" "newsblur.js"];
        dependsOn = [
          "db_mongo"
          "db_postgres"
          "db_redis"
        ];
        log-driver = "journald";
        extraOptions = [
          "--network-alias=newsblur_node"
          "--network=newsblur_default"
        ];
      };
      "task_celery" = {
        image = "newsblur/newsblur_python3";
        environment = {
          "DOCKERBUILD" = "True";
        };
        volumes = [
          # "/home/schwem/nixos-config/nixos/server/services/newsblur:/srv/newsblur:rw"
        ];
        cmd = ["celery" "worker" "-A" "newsblur_web" "-B" "--loglevel=INFO"];
        user = ":";
        log-driver = "journald";
        extraOptions = [
          "--network-alias=task_celery"
          "--network=newsblur_default"
        ];
      };
    };
  };
}
