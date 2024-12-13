{config, ...}: {
  virtualisation.oci-containers.containers = {
    # Containers
    "leantime" = {
      image = "leantime/leantime:latest";
      environmentFiles = [config.sops.secrets.leantime-env.path];
      volumes = [
        "leantime_plugins:/var/www/html/app/Plugins:rw"
        "leantime_public_userfiles:/var/www/html/public/userfiles:rw"
        "leantime_userfiles:/var/www/html/userfiles:rw"
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
        "leantime_db_data:/var/lib/mysql:rw"
      ];
      cmd = ["--character-set-server=UTF8MB4" "--collation-server=UTF8MB4_unicode_ci"];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=leantime_db"
        "--network=leantime_leantime-net"
        "--pull=always"
      ];
    };
  };
}
