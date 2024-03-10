{
  config,
  pkgs,
  ...
}: let
  hostName = config.networking.hostName;
in {
  # environment.systemPackages = with pkgs; [mariadb-galera];

  networking.firewall = {
    allowedTCPPorts = [3306 4567 4568 4444];
    allowedUDPPorts = [4567];
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      mysqld = {
        bind_address = "0.0.0.0";
      };
      galera = {
        wsrep_on = "ON";
        wsrep_debug = "NONE";
        wsrep_retry_autocommit = "3";
        wsrep_provider = "${pkgs.mariadb-galera}/lib/galera/libgalera_smm.so";
        wsrep_cluster_address = "gcomm://articuno.wyvern-map.ts.net,moltres.wyvern-map.ts.net";
        wsrep_cluster_name = "galera";
        wsrep_node_address = "${hostName}.wyvern-map.ts.net";
        wsrep_node_name = hostName;
        wsrep_sst_method = "mariabackup";
        wsrep_sst_auth = "check_repl:check_pass";
        binlog_format = "ROW";
        enforce_storage_engine = "InnoDB";
        innodb_autoinc_lock_mode = "2";
      };
    };
  };
}
