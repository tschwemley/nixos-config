{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../../hardware/audio.nix
    ../../system/fonts.nix
    ../../services/xserver.nix
    ../../users/schwem.nix
  ];

  # steam has to be installed system wide/as a nixos module instead of via home-manager 🤷
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
