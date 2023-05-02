{ config, lib, pkgs, modulesPath, ...}:
{
	imports =
	[ (modulesPath) + "/profiles/qemu-guest.nix")
	];

	boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk" ];
	boot.initrd.kernelModules = [];
	boot.kernelModules = [ "kvm-amd" ];
	boot.extraModulePackages = [ "kvm-amd" ];

	networking.useDHCP = true;
	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirware;
}
