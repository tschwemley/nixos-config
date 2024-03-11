{config, ...}: {
  networking.firewall.allowedTCPPorts = [3306 4567 4568 4444];
  networking.firewall.allowedUDPPorts = [3306 4567 4568 4444];

  # create the directory for /var/lib/mysql on the host
  # systemd.tmpfiles.settings."10-containers"."/var/lib/mysql" = {
  #   d = {mode = "1755";};
  # };

  containers.mysql = let
    hostName = config.networking.hostName;
  in {
    autoStart = true;

    bindMounts."/var/lib/mysql" = {
      hostPath = "/var/lib/mysql";
      isReadOnly = false;
    };

    # network
    # privateNetwork = true;
    #
    # hostAddress = "10.90.1.1";
    # hostAddress6 = "fc00::5";
    # localAddress = "10.90.1.2";
    # localAddress6 = "fc00::6";
    #
    # forwardPorts = [
    #   {
    #     protocol = "tcp";
    #     containerPort = 3306;
    #     hostPort = 3306;
    #   }
    #   {
    #     protocol = "tcp";
    #     containerPort = 4567;
    #     hostPort = 4567;
    #   }
    # ];

    config = {
      lib,
      pkgs,
      ...
    }: {
      # environment = {
      #   systemPackages = with pkgs; [mariadb-galera];
      #   variables = {TERM = "xterm";};
      # };

      networking.firewall.allowedTCPPorts = [3306 4567 4568 4444];

      services.mysql = {
        enable = true;
        package = pkgs.mariadb;
        # group = "root";
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
            wsrep_sst_method = "rsync";
            # wsrep_sst_auth = "check_repl:check_pass";
            binlog_format = "ROW";
            enforce_storage_engine = "InnoDB";
            innodb_autoinc_lock_mode = "2";
          };
        };
        # user = "root";
      };
    };
  };
}
