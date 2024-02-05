let
  devices = {
    # charizard = {
    #   id = "7VRFMPP-LVHA2JL-UY43A5S-4OORFB4-VSW3HQS-TX2L74G-2XNQ2MM-E77I7QO";
    # };
    eevee = {
      addresses = [
        "tcp://10.0.0.3:22000"
      ];
      id = "WB2XRA4-56MQBYX-YESWUVZ-IQOKSMS-RVAIBFM-ICWMMYC-BIKYAIW-IPNDNAY";
    };
    moltres = {
      addresses = [
        "tcp://10.0.0.4:22000"
      ];
      id = "BGTTFO3-3BWN3QE-I5NXYJT-34MNN3X-QXRB22Z-GIZYIFS-SKZ2J3W-ZXKACQE";
    };
  };
in {
  # see: https://search.nixos.org/options?channel=23.11&show=services.syncthing.settings.options&from=0&size=50&sort=relevance&type=packages&query=syncthing
  services = {
    syncthing = {
      enable = true;

      # TODO: fill out if necessary
      # tls
      # cert = null;
      # key = null;

      dataDir = "/var/lib/syncthing";

      # opens TCP/UDP 22000 for transfers and UDP 21027 for discovery
      openDefaultPorts = true;

      settings = {
        inherit devices;
        #folders = {};
        options = {
          globalAnnounceEnabled = false;
          localAnnounceEnabled = false;
          natEnabled = false;
          relaysEnabled = false;
          urAccepted = -1; # don't allow usage data reporting
        };
      };
    };
  };
}
