	{ lib, modulesPath, ... }: {
	  imports =
		[ 
			# This is generated from calling nixos-generate-config
			# TODO: safe to remove? My nix-fu isn't strong enough yet
			(modulesPath + "/installer/scan/not-detected.nix")
			../users/schwem.nix
		];
		
#TODO: check if these are covered via nixos-hardware flake
	  # boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "uas" "usbhid" "sd_mod" ];
	  # boot.kernelModules = [ "kvm-intel" ];
	  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
	  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
		
		networking = {
			hostName = "charizard";
			networkmanager.enable = true;
			useDHCP = true;
		};
	
	system.stateVersion = "23.05"; # Did you read the comment?
}
