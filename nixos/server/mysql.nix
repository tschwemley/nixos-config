{
  config,
  lib,
  pkgs,
  ...
}: let
  hostName = config.networking.hostName;
in {
  networking.firewall.allowedTCPPorts = [3306 4567 4568 4444];
  networking.firewall.allowedUDPPorts = [4444];
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      mysqld = {
        bind-address = "10.10.3.2";
        binlog_format = "ROW";
        default-storage-engine = "innodb";
        enforce_storage_engine = "innodb";
        innodb_autoinc_lock_mode = 2;
        innodb_file_per_table = 1;
        innodb_flush_method = "fsync";
        innodb_lock_wait_timeout = 100;
        innodb_read_only_compressed = 0;
        innodb_use_native_aio = false;
        performance_schema = false;
      };

      # # disable galera for right now
      # galera = lib.mkIf false {
      galera = {
        wsrep_on = true;
        wsrep_retry_autocommit = 3;
        wsrep_provider = "${pkgs.mariadb-galera}/lib/galera/libgalera_smm.so";
        wsrep_cluster_name = "schwem-io";
        wsrep_cluster_address = "gcomm://articuno.wyvern-map.ts.net,moltres.wyvern-map.ts.net";
        # wsrep_sst_method = "rsync_wan";
        wsrep_node_address = "${hostName}.wyvern-map.ts.net";
        wsrep_node_incoming_address = "${hostName}.wyvern-map.ts.net";
        wsrep_node_name = hostName;
        # wsrep_provider_options = "gmcast.listen_addr=tcp://10.10.3.2:4567";
      };
    };
  };
}
