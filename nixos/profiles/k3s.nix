{
  config,
  lib,
  pkgs,
  nodeIP,
  nodeName,
  diskName ? "/dev/vda",
  extraKernelModules ? [],
  role ? "agent",
  useGrub ? false,
  ...
}: let
in {
  imports = [
    ./server.nix
  ];

  # services.resolved = {
  #   enable = true;
  #   fallbackDns = ["1.1.1.1" "1.0.0.1" "2006:4700:4700::1111" "2006:4700:4700::1001"];
  # };
  # systemd.network.enable = true;
}
