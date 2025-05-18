{
  imports = [
    ../../profiles/proxmox-no-storage.nix

    # BUG: binternet search results empty... check if pulling new image resolves or fork and fix
    #       low priority
    # ../../server/alt-frontends/binternet.nix

    ../../server/alt-frontends/nitter.nix
    ../../server/alt-frontends/priviblur
    ../../server/alt-frontends/redlib.nix
    ../../server/automation/home-assistant
    ../../server/knowledge/tiddlywiki
    # ../../server/services/newsblur
    # ../../server/services/webhooks
    ../../system/fonts.nix
  ];

  networking.hostName = "zapados";
  services.tailscale.extraDaemonFlags = ["--socks5-server=0.0.0.0:1080"];
  sops.defaultSopsFile = ./secrets.yaml;
  system.stateVersion = "23.05";
}
