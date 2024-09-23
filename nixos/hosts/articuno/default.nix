{
  imports = [
    (import ../../profiles/buyvm.nix "")

    # server imports
    # ../../../containers/keycloak
    ../../../containers/proxitok
    ../../server/acme
    # ../../server/cockroachdb
    ../../server/dashboard
    ../../server/keycloak
    ../../server/haproxy
    # ../../server/invidious
    ../../server/monitoring
    ../../server/postgresql
    ../../server/searxng
  ];

  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
