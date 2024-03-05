{
  imports = [./virtualhost.nix];

  containers.libreddit = {
    autoStart = true;

    # network
    privateNetwork = true;
    hostAddress = "10.10.3.1";
    localAddress = "10.10.3.2";
    hostAddress6 = "fc00::7";
    localAddress6 = "fc00::8";

    config = {lib, ...}: {
      services.libreddit = {
        enable = true;
        openFirewall = true; # listens on 8080 by default
      };

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [8080];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };
    };
  };
}
