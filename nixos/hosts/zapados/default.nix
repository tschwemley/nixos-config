{
  imports = [
    ../../profiles/proxmox-no-storage.nix

    # BUG: binternet search results empty... check if pulling new image resolves or fork and fix
    #       low priority
    # ../../server/alt-frontends/binternet.nix

    ../../server/alt-frontends/priviblur
    ../../server/alt-frontends/redlib.nix
    ../../server/automation/home-assistant
    ../../server/knowledge/tiddlywiki
    ../../server/services/newsblur
    # ../../server/services/webhooks
    ../../system/fonts.nix
  ];

  networking.hostName = "zapados";
  services.tailscale.extraFlags = ["--socks5-server=127.0.0.1:1080"];
  sops.defaultSopsFile = ./secrets.yaml;
  system.stateVersion = "23.05";
}
