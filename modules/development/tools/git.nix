{ ... }:

{
	programs.git = {
		enable = true;
		config = {
			init = {
				defaultBranch = "main";
			};
			userEmail = "tjschwem@gmail.com";
			userName = "Tyler Schwemley";
			lfs.enable = true;
			extraConfig = {
			  core = {
				whitespace = "trailing-space,space-before-tab";
			  };
			};
		};
	};
}
