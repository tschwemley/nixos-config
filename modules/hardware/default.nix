{ self, inputs, ... }: {
	audio = import ./audio;
	nvidiaDesktop = inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime;
}
