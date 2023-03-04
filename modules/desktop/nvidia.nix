{ config, ... }:
{
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.opengl.enable = true;
	hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
}
