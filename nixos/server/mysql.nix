{
  config,
  pkgs,
  ...
}: let
  hostName = config.networking.hostName;
in {
  networking.firewall.allowedTCPPorts = [3306 4567 4568 4444];

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      mysqld = {
        bind_address = "0.0.0.0";
        binlog_format = "row";
        default_storage_engine = "InnoDB";
        innodb_autoinc_lock_mode = 2;
        # innodb_force_primary_key = 1;
        # innodb_doublewrite = 1;
        # innodb_flush_log_at_trx_commit = 0;
        wsrep_cluster_name = "schwem.io galera cluster";
        wsrep_cluster_address = "gcomm://articuno.wyvern-map.ts.net,moltres.wyvern-map.ts.net";
        wsrep_node_name = hostName;
        wsrep_node_address = "${hostName}.wyvern-map.ts.net";
        wsrep_on = "ON";
        wsrep_provider = "${pkgs.mariadb-galera}/lib/galera/libgalera_smm.so";
        wsrep_sst_method = "rsync";
        # wsrep_slave_threads = 4;
      };
    };
  };
}
