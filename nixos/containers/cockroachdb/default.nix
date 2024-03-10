{
  containers.searxng = {
    autoStart = true;

    # network
    privateNetwork = true;
    hostAddress = "10.10.4.1";
    localAddress = "10.10.4.2";
    hostAddress6 = "fc00::7";
    localAddress6 = "fc00::8";

    config = {lib, ...}: {
      imports = [../.];

      services.cockroachdb = {
        enable = true;
        locality = "country=us,region=us-east,datacenter=ny";
        openPorts = true;
      };
    };
  };
}
