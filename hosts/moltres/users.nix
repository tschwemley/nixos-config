# { homeConfigurations, nixosModules, ... }: 
# let
# 	adminGroups = [ "wheel" "networkmanager" ];
# in
# {
# 	users.users.k3s = {
# 		isNormalUsers = true;
# 		extraGroups = $adminGroups;
# 		home.username = "k3s";
# 		home.homeDirectory = "/home/k3s";
# 	};
# 	
# 	nixosModules.homeManager = {
# 		users.root = {}; # this allows root access to shareModules
#
# 		users.k3s = import homeConfigurations.k3s;
# 	};
# 	
# }
