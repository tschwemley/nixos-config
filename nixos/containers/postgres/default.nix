{
  containers.postgresql = {
    autoStart = true;

    privateNetwork = true;
    hostAddress = "10.10.3.1";
    localAddress = "10.10.3.2";
    hostAddress6 = "fc00::3";
    localAddress6 = "fc00::4";

    config = {
      lib,
      pkgs,
      ...
    }: {
      imports = [../.];

      nixpkgs.config.allowUnfree = true;

      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_16;
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [5432];
      };
    };
  };
}
