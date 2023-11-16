{ lib, modulesPath, ... }:
{
	imports = [
		(modulesPath + "/profiles/qemu-guest.nix")
	];

	boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk" ];
	boot.kernelModules = [ "kvm-amd" ];
	
	boot.supportedFilesystems = [ "btrfs" ];
	boot.loader.grub = {
		devices = [ "/dev/vda" ];
		version = 2;
		# efiSupport = true;
		# efiInstallAsRemovable = true;
	};

	disko.devices = import ./disk-config.nix {
		inherit lib;
	};

	networking.hostName = "moltres";
	
	sops = {
		defaultSopsFile = ./secrets.yaml;
		age.sshKeyPaths = ./moltres.pub;
		age.keyFile = "/var/lib/sops-nix/key.txt";
		# This will generate a new key if the key specified above does not exist
		age.generateKey = true;
	};

	users.users.root.openssh.authorizedKeys.keys = [ (builtins.readFile ./moltres.pub) ];
}
