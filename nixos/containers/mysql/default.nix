{config, ...}: let
  hostName = config.networking.hostName;
in {
  containers.mysql = {
    autoStart = true;

    privateNetwork = true;
    hostAddress = "10.10.3.1";
    localAddress = "10.10.3.2";
    hostAddress6 = "fc00::3";
    localAddress6 = "fc00::4";

    config = {
      config,
      lib,
      pkgs,
      ...
    }: {
      imports = [../.];

      nixpkgs.config.allowUnfree = true;

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

          # Disable galera for now
          galera = lib.mkIf false {
            wsrep_on = true;
            wsrep_retry_autocommit = 3;
            wsrep_provider = "${pkgs.mariadb-galera}/lib/galera/libgalera_smm.so";
            wsrep_cluster_name = "schwem-io";
            wsrep_cluster_address = "gcomm://articuno.wyvern-map.ts.net,moltres.wyvern-map.ts.net";
            # wsrep_sst_method = "rsync_wan";
            wsrep_node_address = "${hostName}.wyvern-map.ts.net";
            wsrep_node_incoming_address = "${hostName}.wyvern-map.ts.net";
            wsrep_node_name = hostName;
            wsrep_provider_options = "gmcast.listen_addr=tcp://10.10.3.2:4567";
            # wsrep_provider_options = "gmcast.listen_addr=tcp://${LT.this.ltnet.IPv4}:4567";
          };
        };
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [5432];
      };
    };
  };
}
