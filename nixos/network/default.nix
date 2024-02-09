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
}
