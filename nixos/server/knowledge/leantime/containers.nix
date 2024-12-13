{config, ...}: let
  stateDir = "/var/lib/leantime";
in {
  systemd.tmpfiles.rules = [
    "d /var/lib/leantime/db_data 0755 root root - -"
    "d /var/lib/leantime/plugins 0755 root root - -"
    "d /var/lib/leantime/public 0755 root root - -"
    "d /var/lib/leantime/userfiles 0755 root root - -"
  ];

  virtualisation.oci-containers.containers = {
    # Containers
    "leantime" = {
      image = "leantime/leantime:latest";
      environmentFiles = [config.sops.secrets.leantime-env.path];
      volumes = [
        "${stateDir}/plugins:/var/www/html/app/Plugins:rw"
        "${stateDir}/public_userfiles:/var/www/html/public/userfiles:rw"
        "${stateDir}/userfiles:/var/www/html/userfiles:rw"
      ];
      ports = [
        "127.0.0.1:8081:80/tcp"
      ];
      dependsOn = [
        "mysql_leantime"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=leantime"
        "--network=leantime_leantime-net"
        "--pull=always"
      ];
    };

    "mysql_leantime" = {
      image = "mariadb";
      environmentFiles = [config.sops.secrets.leantime-env.path];
      volumes = [
        "${stateDir}/db_data:/var/lib/mysql:rw"
      ];
      cmd = ["--character-set-server=UTF8MB4" "--collation-server=UTF8MB4_unicode_ci"];
      ports = ["3306/tcp"];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=leantime_db"
        "--network=leantime_leantime-net"
        "--pull=always"
      ];
    };
  };
}
