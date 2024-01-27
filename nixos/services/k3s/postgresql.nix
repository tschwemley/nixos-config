{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [5432];
  services.postgresql = {
    enable = true;
    ensureDatabases = ["kubernetes"];
    enableTCPIP = true;
    port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #...
      #type database DBuser origin-address auth-method
      # ipv4
      local all      all     peer          map=superuser_map
      host  all      all     127.0.0.1/32  trust
      host  all      all     10.0.0.1/32   trust
      host  all      all     10.0.0.2/32   trust
      host  all      all     10.0.0.3/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';

    identMap = ''
      # ArbitraryMapName systemUser DBUser
         superuser_map      root      postgres
         # Let other names login as themselves
         superuser_map      /^(.*)$   \1
    '';
  };
}
