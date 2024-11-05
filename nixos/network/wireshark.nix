{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.termshark];

  # enable wireshark (gui) on desktop hosts
  programs.wireshark = {
    enable = builtins.elem config.networking.hostName ["charizard" "pikachu"];
    package = pkgs.wireshark;
  };
}
