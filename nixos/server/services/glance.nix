{
  self,
  config,
  lib,
  ...
}:
let
  host = "127.0.0.1";
  port = self.lib.toInt config.variables.ports.glance;
in
{
  services = {
    glance = {
      enable = true;
      environmentFile = config.sops.secrets.glanceEnv.path;
      # REF: https://github.com/glanceapp/glance/blob/main/docs/configuration.md
      settings = {
        server = { inherit host port; };

        # TODO:
        #   1. decide if want/need more than just the dashboard/home page
        #   2. add widgets:
        #     a. rss
        #     b. a useful calendar (default is basically just a display)
        #     c. more...
        #
        # REF: https://github.com/glanceapp/glance/blob/main/docs/configuration.md#widgets
        pages = [
          {
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "clock";
                    timezones = [
                      { timezone = "\${DEFAULT_TIMEZONE}"; }
                    ];
                  }
                  {
                    type = "weather";
                    location = "\${DEFAULT_LOCATION}";
                    units = "imperial";
                  }
                ];
              }

              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                    search-engine = "https://kagi.com/search?q={QUERY}";
                  }
                  {
                    type = "split-column";
                    widgets = [
                      { type = "hacker-news"; }
                      { type = "lobsters"; }
                    ];
                  }
                ];
              }

              {
                size = "small";
                widgets = [
                  # TODO: figure out what's going here
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

  sops.secrets.glanceEnv = {
    format = "dotenv";
    sopsFile = "${self.lib.secrets.server}/glance.env";
  };
}
