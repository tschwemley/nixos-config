{
  services.netbird = {
    enable = true;
    tunnels.schwem-io.environment = {
      NB_MANAGEMENT_URL = "https://netbird.schwem.io";
    };
  };
}
