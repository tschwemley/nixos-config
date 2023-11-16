{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./.
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../modules/hardware/audio.nix
    ../modules/programs/barrier.nix
    ../modules/services/mullvad.nix
    ../modules/programs/steam.nix
    ../modules/system/fonts.nix
    ../modules/services/xserver.nix
    ../modules/users/schwem.nix
  ];

  # on my personal machines I don't want to be prompted for my pw
  security.sudo.wheelNeedsPassword = false;

  /*
    TODO: make this specific to Charizard if works - testing a fix for Brave having SIGSEGV that
          may be related to not being able to find a libva driver. If confirmed working then move
          to brave module and make brave a system-level program.
  environment.systemPackages = with pkgs; [
    upower
    vaapiVdpau
    # I don't think using the 32 bit version would make sense but here in case it works and the other doesn't
    #driversi686Linux.vaapiVdpau
  ];
  */
}
