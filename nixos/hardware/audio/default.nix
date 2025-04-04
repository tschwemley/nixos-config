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
    soundcardPciId = "00:1f.3"; # TODO: check this value on pikachu and define via host config
  };
}
