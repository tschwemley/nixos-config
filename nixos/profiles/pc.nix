{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./.
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../modules/hardware/audio.nix
    ../modules/system/fonts.nix
    ../modules/services/xserver.nix
    ../modules/users/schwem.nix
  ];

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

  #TODO: move this into programs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
