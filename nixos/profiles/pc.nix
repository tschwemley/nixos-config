{inputs, ...}: {
  imports = [
    ./.
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../modules/hardware/audio.nix
    ../modules/system/fonts.nix
    ../modules/services/xserver.nix
    ../modules/users/schwem.nix
  ];

  # steam has to be installed system wide/as a nixos module instead of via home-manager 🤷
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
