{
  # networking.firewall.allowedTCPPorts = [3306];

  containers.mysql = {
    autoStart = true;

    # bindMounts."/run/secrets/searxng" = {
    #   hostPath = config.sops.secrets.searxng.path;
    # };

    # network
    privateNetwork = true;

    hostAddress = "10.90.1.1";
    hostAddress6 = "fc00::5";
    localAddress = "10.90.1.2";
    localAddress6 = "fc00::6";

    forwardPorts = [
      {
        protocol = "tcp";
        containerPort = 3306;
        hostPort = 3306;
      }
      {
        protocol = "tcp";
        containerPort = 4567;
        hostPort = 4567;
      }
    ];

    config = {
      lib,
      pkgs,
      ...
    }: {
      environment.systemPackages = with pkgs; [busybox];
      networking.firewall.allowedTCPPorts = [3306 4567];
      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
        settings = {
          # [galera]
          galera = {
            # Mandatory settings
            wsrep_on = "ON";
            wsrep_provider = "${pkgs.mariadb-galera}/lib/galera/libgalera_smm.so";
            wsrep_cluster_name = "schwem.io galera cluster";
            wsrep_cluster_address = "gcomm://articuno.wyvern-map.ts.net";
            # wsrep_cluster_address = "gcomm://articuno.wyvern-map.ts.net,moltres.wyvern-map.ts.net";
            # wsrep_cluster_address = "gcomm://10.90.1.2,10.90.2.2,10.90.3.2";
            binlog_format = "row";
            default_storage_engine = "InnoDB";
            innodb_autoinc_lock_mode = 2;
            innodb_force_primary_key = 1;
            innodb_doublewrite = 1;

            bind_address = "0.0.0.0";

            # Optional settings
            wsrep_slave_threads = 4;
            innodb_flush_log_at_trx_commit = 0;
            wsrep_node_name = "articuno";
            wsrep_node_address = "articuno.wyvern-map.ts.net";
          };
        };
      };
    };
  };
}
