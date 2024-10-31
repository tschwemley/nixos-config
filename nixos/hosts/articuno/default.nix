{
  imports = [
    (import ../../profiles/buyvm.nix "")

    # server imports
    ../../server/dashboard

    ../../server/security/acme
    ../../server/security/auth/keycloak
    ../../server/infrastructure/haproxy
    ../../server/infrastructure/monitoring
    ../../server/infrastructure/postgresql
    ../../server/services/searxng
  ];

  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  services.tailscale.extraUpFlags = ["--advertise-tags=tags:server,tags:master"];

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
