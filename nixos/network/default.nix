{
  config,
  lib,
  ...
}: {
  # options = let
  #   inherit (lib) types mkOption;
  # in {
  #   networking = {
  #     defaultDevice = mkOption {type = types.str;};
  #     ipv4 = {
  #       address = mkOption {type = types.str;};
  #       gateway = mkOption {type = types.str;};
  #     };
  #     ipv6 = {
  #       address = mkOption {type = types.str;};
  #       gateway = mkOption {type = types.str;};
  #     };
  #   };
  # };

  # config = {
  services.openssh = {
    enable = true;
    settings = {
      GatewayPorts = "yes";
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };

  systemd.network = {
    enable = true;
    #   networks = let
    #     Address = config.networking.ipv4.address;
    #     Destination = "0.0.0.0";
    #     DNS = "1.1.1.1 1.0.0.1";
    #     Gateway = config.networking.ipv4.gateway;
    #     name = config.networking.defaultDevice;
    #   in {
    #     "10-${name}" = {
    #       inherit name;
    #       # matchConfig = {Name = "ens3";};
    #       networkConfig = {inherit Address DNS;};
    #       routes = [
    #         {routeConfig = {inherit Destination Gateway;};}
    #       ];
    #     };
    #   };
  };
  # };
}
