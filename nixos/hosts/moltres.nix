{ self, lib, ... }:
let 
	disks = {
		imports = [
			(import ../modules/disks/btrfs-ephemeral.nix { 
				diskName = "/dev/vda"; 
				swapSize = "2048";
			})
			(import ../modules/disks/btrfs-block-storage.nix { diskName = "/dev/sda"; })
		];
	};
in
{
	imports = [
		disks
		../modules/k3s
		../modules/services/keycloak.nix
	];
	
	boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk" ];
	boot.kernelModules = [ "kvm-amd" ];
	
	boot.supportedFilesystems = [ "btrfs" ];
	boot.loader.grub = {
		devices = [ "/dev/vda" ];
		version = 2;
		efiSupport = true;
		# efiInstallAsRemovable = true;
	};

	networking.hostName = "moltres";
	
	sops = {
		defaultSopsFile = ./secrets.yaml;
		age.sshKeyPaths = ./moltres.pub;
		age.keyFile = "/var/lib/sops-nix/key.txt";
		# This will generate a new key if the key specified above does not exist
		age.generateKey = true;
	};

	services.getty.autologinUser = "k3s";
	
	# don't update this
	system.stateVersion = "23.11"; #nixos-unstable 

	users.users.root.openssh.authorizedKeys.keys = [ (builtins.readFile ./moltres.pub) ];
}
