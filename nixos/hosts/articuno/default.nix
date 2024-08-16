{
  imports =
    [
      (import ../../profiles/buyvm.nix "")

      # server imports
      ../../../containers/keycloak
      ../../../containers/searxng
      ../../server/acme
      ../../server/cockroachdb
      ../../server/haproxy
      ../../server/monitoring
      ../../server/oauth2-proxy
    ];

  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
