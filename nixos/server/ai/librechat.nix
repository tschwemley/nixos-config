# Auto-generated using compose2nix v0.3.1.
{
  self,
  config,
  pkgs,
  ...
}: let
  dotenv = config.sops.secrets.librechat-env.path;
  db-env = config.sops.secrets.librechat-db-env.path;

  stateDir = "/var/lib/librechat";
  user = "librechat";
in {
  sops.secrets = let
    group = user;
    key = "";
    mode = "0400";
    owner = user;
  in {
    librechat-config = {
      inherit group key mode owner;
      sopsFile = self.lib.secret "server" "librechat.yaml";
    };

    librechat-env = {
      # inherit group key mode owner;
      inherit group mode owner;
      format = "dotenv";
      sopsFile = self.lib.secret "server" "librechat.env";
    };

    librechat-db-env = {
      # inherit group key mode owner;
      inherit group mode owner;
      format = "dotenv";
      sopsFile = self.lib.secret "server" "librechat-db.env";
    };
  };

  systemd = {
    services = {
      "podman-LibreChat-API" = {
        serviceConfig = {
          Restart = self.lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-librechat_default.service"
        ];
        requires = [
          "podman-network-librechat_default.service"
        ];
        partOf = [
          "podman-compose-librechat-root.target"
        ];
        wantedBy = [
          "podman-compose-librechat-root.target"
        ];
      };

      "podman-LibreChat-NGINX" = {
        serviceConfig = {
          Restart = self.lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-librechat_default.service"
        ];
        requires = [
          "podman-network-librechat_default.service"
        ];
        partOf = [
          "podman-compose-librechat-root.target"
        ];
        wantedBy = [
          "podman-compose-librechat-root.target"
        ];
      };

      "podman-chat-meilisearch" = {
        serviceConfig = {
          Restart = self.lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-librechat_default.service"
        ];
        requires = [
          "podman-network-librechat_default.service"
        ];
        partOf = [
          "podman-compose-librechat-root.target"
        ];
        wantedBy = [
          "podman-compose-librechat-root.target"
        ];
      };

      "podman-chat-mongodb" = {
        serviceConfig = {
          Restart = self.lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-librechat_default.service"
        ];
        requires = [
          "podman-network-librechat_default.service"
        ];
        partOf = [
          "podman-compose-librechat-root.target"
        ];
        wantedBy = [
          "podman-compose-librechat-root.target"
        ];
      };

      "podman-librechat-rag_api" = {
        serviceConfig = {
          Restart = self.lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-librechat_default.service"
        ];
        requires = [
          "podman-network-librechat_default.service"
        ];
        partOf = [
          "podman-compose-librechat-root.target"
        ];
        wantedBy = [
          "podman-compose-librechat-root.target"
        ];
      };

      "podman-librechat-vectordb" = {
        serviceConfig = {
          Restart = self.lib.mkOverride 90 "always";
        };
        after = [
          "podman-network-librechat_default.service"
          "podman-volume-librechat_pgdata2.service"
        ];
        requires = [
          "podman-network-librechat_default.service"
          "podman-volume-librechat_pgdata2.service"
        ];
        partOf = [
          "podman-compose-librechat-root.target"
        ];
        wantedBy = [
          "podman-compose-librechat-root.target"
        ];
      };

      # Networks
      "podman-network-librechat_default" = {
        path = [pkgs.podman];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = "podman network rm -f librechat_default";
        };
        script = ''
          podman network inspect librechat_default || podman network create librechat_default
        '';
        partOf = ["podman-compose-librechat-root.target"];
        wantedBy = ["podman-compose-librechat-root.target"];
      };

      # Volumes
      "podman-volume-librechat_pgdata2" = {
        path = [pkgs.podman];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          podman volume inspect librechat_pgdata2 || podman volume create librechat_pgdata2
        '';
        partOf = ["podman-compose-librechat-root.target"];
        wantedBy = ["podman-compose-librechat-root.target"];
      };
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    targets."podman-compose-librechat-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = ["multi-user.target"];
    };

    tmpfiles.rules = [
      "d ${stateDir} 0750 librechat librechat - -"

      "d ${stateDir}/images 0750 librechat librechat - -"
      "d ${stateDir}/logs 0750 librechat librechat - -"
      "d ${stateDir}/uploads 0750 librechat librechat - -"

      "d ${stateDir}/data-node 0750 librechat librechat - -"
      "d ${stateDir}/librechat_pgdata2 0750 librechat librechat - -"
      "d ${stateDir}/meili_data_v1.12 0750 librechat librechat - -"
    ];
  };

  users = {
    groups.${user} = {};
    users.${user} = {
      isSystemUser = true;
      group = user;
    };
  };

  virtualisation.oci-containers.containers = {
    # Containers
    "LibreChat-API" = {
      image = "ghcr.io/danny-avila/librechat-dev-api:latest";
      environment = {
        NODE_ENV = "production";
        RAG_API_URL = "http://rag_api:${config.variables.ports.librechat-rag}";
      };
      environmentFiles = [dotenv];
      volumes = [
        "${config.sops.secrets.librechat-config.path}:/app/librechat.yaml:rw"

        "${stateDir}/images:/app/client/public/images:rw"
        "${stateDir}/logs:/app/api/logs:rw"
        "${stateDir}/uploads:/app/uploads:rw"
      ];
      ports = [
        "${config.variables.ports.librechat}:3080/tcp"
      ];
      dependsOn = [
        "chat-mongodb"
        "librechat-rag_api"
      ];
      log-driver = "journald";
      extraOptions = [
        "--add-host=host.docker.internal:host-gateway"
        "--network-alias=api"
        "--network=librechat_default"
      ];
    };

    "LibreChat-NGINX" = {
      image = "nginx:1.27.0-alpine";
      volumes = [
        "${stateDir}/client/nginx.conf:/etc/nginx/conf.d/default.conf:rw"
      ];
      ports = [
        "80/tcp"
        "443/tcp"
        # "80:80/tcp"
        # "443:443/tcp"
      ];
      dependsOn = [
        "LibreChat-API"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=client"
        "--network=librechat_default"
      ];
    };

    "chat-meilisearch" = {
      image = "getmeili/meilisearch:v1.12.3";
      environment = {
        MEILI_NO_ANALYTICS = "true";
      };
      environmentFiles = [dotenv];
      volumes = [
        "${stateDir}/meili_data_v1.12:/meili_data:rw"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=meilisearch"
        "--network=librechat_default"
      ];
    };

    "chat-mongodb" = {
      image = "mongo";
      volumes = [
        "${stateDir}/data-node:/data/db:rw"
      ];
      cmd = ["mongod" "--noauth"];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=mongodb"
        "--network=librechat_default"
      ];
    };

    "librechat-rag_api" = {
      image = "ghcr.io/danny-avila/librechat-rag-api-dev-lite:latest";
      environment = {
        DB_HOST = "vectordb";
      };
      environmentFiles = [dotenv];
      dependsOn = [
        "librechat-vectordb"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=rag_api"
        "--network=librechat_default"
      ];
    };

    "librechat-vectordb" = {
      image = "ankane/pgvector:latest";
      environmentFiles = [db-env];
      volumes = [
        "${stateDir}/librechat_pgdata2:/var/lib/postgresql/data:rw"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=vectordb"
        "--network=librechat_default"
      ];
    };
  };
}
