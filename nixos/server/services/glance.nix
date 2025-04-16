{
  config,
  lib,
  ...
}: let
  host = "127.0.0.1";
  port = lib.toInt config.variables.ports.glance;
in {
  services = {
    glance = {
      enable = true;
      # REF: https://github.com/glanceapp/glance/blob/main/docs/configuration.md
      settings = {
        server = {inherit host port;};

        # TODO:
        #   1. decide if want/need more than just the dashboard/home page
        #   2. add widgets:
        #     a. search
        #     b. rss
        #     c. weather
        #     d. clock
        #     e. rss
        #     f. more... REF: https://github.com/glanceapp/glance/blob/main/docs/configuration.md#widgets
        pages = [
          {
            columns = [
              {
                size = "small";
                widgets = [
                  {type = "calendar";}
                  {
                    type = "weather";
                    location = "Detroit, MI";
                  }
                ];
              }

              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                  }
                  {
                    type = "weather";
                    location = "Detroit, MI";
                  }
                ];
              }
            ];
            name = "Home";
          }
        ];

        theme = {
          # gruvbox dark
          background-color = "0 0 16";
          primary-color = "43 59 81";
          positive-color = "61 66 44";
          negative-color = "6 96 59";
        };
      };
    };

    nginx.virtualHosts."schwem.io".locations."/".proxyPass = "http://${host}:${toString port}";
  };
}
