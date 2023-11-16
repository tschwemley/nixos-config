{ ... }:
let 
	k3s = import ./k3s.nix;
	schwem = import ./schwem.nix;
in
{
	flake.users = {
		inherit k3s schwem;
	};
}
