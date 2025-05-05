{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.musnix.nixosModules.musnix
    ./bluetooth.nix
    ./pipewire.nix
    ./scarlett8i6.nix
  ];

  musnix = {
    enable = true;

    kernel = {
      packages = pkgs.linuxPackages_latest_rt;
      realtime = true;
    };

    rtcqs.enable = true;
    # TODO: pikachu has the same value but I want to try disabling this for the time being to
    # make sure it's not causing any issues
    # soundcardPciId = "00:1f.3"; # TODO: check this value on pikachu and define via host config
  };
}
