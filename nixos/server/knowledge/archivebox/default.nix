# Auto-generated using compose2nix v0.2.3.
{
  self,
  pkgs,
  lib,
  ...
}: {
  services.nginx.nixos-config = {};

  virtualisation = {
    oci-containers = {
      containers = {
        # Containers
        "archivebox-archivebox" = {
          image = "archivebox/archivebox:latest";
          environment = {
            "ALLOWED_HOSTS" = "*";
            "CSRF_TRUSTED_ORIGINS" = "https://archivebox.example.com";
            "PUBLIC_ADD_VIEW" = "False";
            "PUBLIC_INDEX" = "True";
            "PUBLIC_SNAPSHOTS" = "True";
            "SEARCH_BACKEND_ENGINE" = "sonic";
            "SEARCH_BACKEND_HOST_NAME" = "sonic";
            "SEARCH_BACKEND_PASSWORD" = "SomeSecretPassword";
          };
          volumes = [
            "/home/schwem/nixos-config/data:/data:rw"
          ];
          ports = [
            "${self.lib.port-map.archiveboxWeb}:8000/tcp"
          ];
          log-driver = "journald";
          extraOptions = [
            "--network-alias=archivebox"
            "--network=archivebox_default"
          ];
        };

        "archivebox-archivebox_scheduler" = {
          image = "archivebox/archivebox:latest";
          environment = {
            "TIMEOUT" = "120";
          };
          volumes = [
            "/home/schwem/nixos-config/data:/data:rw"
          ];
          cmd = ["schedule" "--foreground" "--update" "--every=day"];
          log-driver = "journald";
          extraOptions = [
            "--network-alias=archivebox_scheduler"
            "--network=archivebox_default"
          ];
        };

        "archivebox-novnc" = {
          image = "theasp/novnc:latest";
          environment = {
            "DISPLAY_HEIGHT" = "1080";
            "DISPLAY_WIDTH" = "1920";
            "RUN_XTERM" = "no";
          };
          ports = [
            "${self.lib.port-map.archiveboxNovnc}:8080/tcp"
          ];
          log-driver = "journald";
          extraOptions = [
            "--network-alias=novnc"
            "--network=archivebox_default"
          ];
        };

        "archivebox-sonic" = {
          image = "valeriansaliou/sonic:latest";
          environment = {
            "SEARCH_BACKEND_PASSWORD" = "SomeSecretPassword";
          };
          volumes = [
            "/home/schwem/nixos-config/data/sonic:/var/lib/sonic/store:rw"
          ];
          log-driver = "journald";
          extraOptions = [
            "--network-alias=sonic"
            "--network=archivebox_default"
          ];
        };
      };
    };
  };

  systemd = {
    services = {
      "podman-archivebox-archivebox" = {
        serviceConfig = {
          Restart = lib.mkOverride 500 "no";
        };
        after = [
          "podman-network-archivebox_default.service"
        ];
        requires = [
          "podman-network-archivebox_default.service"
        ];
        partOf = [
          "podman-compose-archivebox-root.target"
        ];
        wantedBy = [
          "podman-compose-archivebox-root.target"
        ];
      };

      "podman-archivebox-archivebox_scheduler" = {
        serviceConfig = {
          Restart = lib.mkOverride 500 "no";
        };
        after = [
          "podman-network-archivebox_default.service"
        ];
        requires = [
          "podman-network-archivebox_default.service"
        ];
        partOf = [
          "podman-compose-archivebox-root.target"
        ];
        wantedBy = [
          "podman-compose-archivebox-root.target"
        ];
      };

      "podman-archivebox-novnc" = {
        serviceConfig = {
          Restart = lib.mkOverride 500 "no";
        };
        after = [
          "podman-network-archivebox_default.service"
        ];
        requires = [
          "podman-network-archivebox_default.service"
        ];
        partOf = [
          "podman-compose-archivebox-root.target"
        ];
        wantedBy = [
          "podman-compose-archivebox-root.target"
        ];
      };

      "podman-archivebox-sonic" = {
        serviceConfig = {
          Restart = lib.mkOverride 500 "no";
        };
        after = [
          "podman-network-archivebox_default.service"
        ];
        requires = [
          "podman-network-archivebox_default.service"
        ];
        partOf = [
          "podman-compose-archivebox-root.target"
        ];
        wantedBy = [
          "podman-compose-archivebox-root.target"
        ];
      };

      # Networks
      "podman-network-archivebox_default" = {
        path = [pkgs.podman];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = "podman network rm -f archivebox_default";
        };

        script = ''
          podman network inspect archivebox_default || podman network create archivebox_default
        '';

        partOf = ["podman-compose-archivebox-root.target"];
        wantedBy = ["podman-compose-archivebox-root.target"];
      };
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    targets."podman-compose-archivebox-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };

      wantedBy = ["multi-user.target"];
    };
  };
}
