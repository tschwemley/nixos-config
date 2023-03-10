# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
	  imports =
	    [
		  # ./audio.nix
		  #./file-system.nix
		  ./boot.nix
		  ./locale.nix
		  ./network.nix
		  ./hardware-configuration.nix
		  ./xserver.nix
	    ];

	      nix.settings.experimental-features = [ "nix-command" "flakes" ];

	nixpkgs.config.allowUnfree = true; 	


	  services.xserver.videoDrivers = [ "nvidia" ];
	  hardware.opengl.enable = true;
	  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;


	  # enable intel 
	  hardware.opengl.extraPackages = with pkgs; [
		intel-compute-runtime
		libva
	  ];

		#TODO: move this out
	  # Enable automatic login for the user.
	  services.getty.autologinUser = "schwem";

	  # This value determines the NixOS release from which the default
	  # settings for stateful data, like file locations and database versions
	  # on your system were taken. It‘s perfectly fine and recommended to leave
	  # this value at the release version of the first install of this system.
	  # Before changing this value read the documentation for this option
	  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	  system.stateVersion = "22.11"; # Did you read the comment?

	  #TODO: move this somewhere else
	  environment.systemPackages = with pkgs; [
		bun
		cargo
		nodejs
		rustc
		rustfmt
	  ];
}
