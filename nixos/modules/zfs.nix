{ ... }:
{
	boot.supportedFilesystems = [ "zfs" ];
	boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
	#networking.hostId = <host-id>; # For example: head -c 8 /etc/machine-id
}
