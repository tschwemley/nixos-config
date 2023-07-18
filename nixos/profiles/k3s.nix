{pkgs, diskName ? "/dev/vda", ...}: {
  imports = [
	  ../modules/disks/k3s.nix { inherit diskName; }
	  ./server.nix
  ];
}
