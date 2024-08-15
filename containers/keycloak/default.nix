{config, ...}: {
  imports = [./virtualhost.nix];

  networking.firewall.trustedInterfaces = ["ve-keycloak"];

  sops.secrets.db_password = {
    sopsFile = ./secrets.yaml;
    mode = "0444";
  };

  containers.keycloak = {
    autoStart = true;

    bindMounts."/run/secrets/db_password" = {
      hostPath = config.sops.secrets.db_password.path;
    };

    # network
    privateNetwork = true;
    hostAddress = "10.10.1.1";
    localAddress = "10.10.1.2";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";

    config = let 
      keycloak = import ./keycloak.nix;
    in {lib, ...}: {
      imports = [
        ../.
        keycloak
      ];

      networking.firewall.allowedTCPPorts = [80];

      systemd.services.keycloak.script = ''
        ${config.systemd.services.keycloak.script}
        nyxx
      '';
    };
  };
  # config.systemd.services.keycloak.script = (builtins.replaceStrings ["kc.sh --verbose start --optimized"] ["kc.sh --verbose start --optimized --spi-connections-jpa-legacy-migration-strategy=manual"] config.systemd.services.keycloak.script);
}
