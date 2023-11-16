{ self, inputs, ... }: {
	audio = import ./audio;
	disks = import ./disks;
	
	nvidia = {
		desktop = inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime;
		laptop = inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime;
	}
}
