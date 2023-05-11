{ home-manager, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userEmail = "tjschwem@gmail.com";
		userName = "Tyler Schwemley";
		lfs.enable = true;
		extraConfig = {
		  core = {
			whitespace = "trailing-space,space-before-tab";
		  };
		};
	};
}
