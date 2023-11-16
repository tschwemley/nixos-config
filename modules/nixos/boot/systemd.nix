{ ... }: {
	boot.initrd.systemd.enable = true;
	boot.loader = {
	systemd-boot = {
		enable = true;
		consoleMode = "max";
	};
	efi.canTouchEfiVariables = true;
};
}
