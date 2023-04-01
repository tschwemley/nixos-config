{ ... }:
let
	mkUser = name: {
		home.username = name;	
		home.homeDirectory = "/home/${name}";
	};
in
{
	flake = {
		nixosModules = {
			users = {
				kubernetesAgent = mkUser "k8s-agent";
				kubernetesServer = mkUser "k8s-server";
				personal = mkUser "schwem";
				work = mkUser "tschwemley";
			};
		};	
	};
}
