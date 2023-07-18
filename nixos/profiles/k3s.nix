{pkgs, ...}: {
  imports = [
	  ../modules/disks/k3s.nix
	  ./server.nix
  ];
}
