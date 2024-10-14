{
  imports = [
    (import ../../profiles/buyvm.nix "")

    # server imports
    # ../../../containers/proxitok
    ../../server/acme
    ../../server/auth
    ../../server/dashboard
    ../../server/haproxy
    ../../server/monitoring
    ../../server/postgresql
    ../../server/searxng
  ];

  networking.hostName = "articuno";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  services.tailscale.extraUpFlags = [ "--advertise-tags=tags:server,tags:master" ];

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
