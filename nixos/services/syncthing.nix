{ pkgs, ... }:
let
  devices = {
    # charizard = {
    #   id = "7VRFMPP-LVHA2JL-UY43A5S-4OORFB4-VSW3HQS-TX2L74G-2XNQ2MM-E77I7QO";
    # };
    eevee = {
      addresses = [
        "tcp://10.0.0.2:22000"
        "tcp://10.0.0.3:22000"
        "tcp://10.0.0.4:22000"
        "tcp://10.0.0.5:22000"
        "tcp://10.0.0.6:22000"
      ];
      id = "WB2XRA4-56MQBYX-YESWUVZ-IQOKSMS-RVAIBFM-ICWMMYC-BIKYAIW-IPNDNAY";
    };
    flareon = {
      addresses = [
        "tcp://10.0.0.2:22000"
        "tcp://10.0.0.3:22000"
        "tcp://10.0.0.4:22000"
        "tcp://10.0.0.5:22000"
        "tcp://10.0.0.6:22000"
      ];
      id = "FDYU7II-QX4EIXB-QCO7GFQ-ZPVBCP6-5HS3GZ4-MY5XGDG-YZUG7VX-74CL3QD";
    };
    jolteon = {
      addresses = [
        "tcp://10.0.0.2:22000"
        "tcp://10.0.0.3:22000"
        "tcp://10.0.0.4:22000"
        "tcp://10.0.0.5:22000"
        "tcp://10.0.0.6:22000"
      ];
      id = "UTSR43R-YMCLU6Z-4G7G3XI-IPNXSYO-5XK25ZT-MXYLLNE-G76NHH3-V55CHQQ";
    };
    moltres = {
      addresses = [
        "tcp://10.0.0.2:22000"
        "tcp://10.0.0.3:22000"
        "tcp://10.0.0.4:22000"
        "tcp://10.0.0.5:22000"
        "tcp://10.0.0.6:22000"
      ];
      id = "BGTTFO3-3BWN3QE-I5NXYJT-34MNN3X-QXRB22Z-GIZYIFS-SKZ2J3W-ZXKACQE";
    };
    zapdos = {
      addresses = [
        "tcp://10.0.0.2:22000"
        "tcp://10.0.0.3:22000"
        "tcp://10.0.0.4:22000"
        "tcp://10.0.0.5:22000"
        "tcp://10.0.0.6:22000"
      ];
      id = "KQRCWQS-LSUBANY-YXBV4YC-ZL5BSLU-M2PUNPJ-PR4MFAV-MUT3AUA-UYPRNQ6";
    };
  };

  folders = {
    "/storage/media" = {
      id = "media";
      devices = [
        "zapdos"
        "moltres"
        "eevee"
        "flareon"
        "jolteon"
      ];
    };
  };
in
{
  environment.systemPackages = with pkgs; [ syncthing ];
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
        inherit devices folders;
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
