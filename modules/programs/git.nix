{ ... }:
{
	programs.git = {
		enable = true;
		userEmail = "tjschwem@gmail.com";
		userName = "Tyler Schwemley";
		
		lfs.enable = true;

		aliases = {
			b = "branch";
			co = "checkout";
			s = "status";
		};

		extraConfig = {
		  core = {
			whitespace = "trailing-space,space-before-tab";
		  };
		  
		 # TODO: remove this if not using for one of servers
		 #  url = {
			# "ssh://git@host" = {
			#   insteadOf = "otherhost";
			# };
		 #  };
		};
	};
}
