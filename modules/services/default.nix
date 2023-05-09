{ ... }: {
	k3s = import ./k3s;
  
	common = {
		# Enable the OpenSSH daemon.
		services.openssh.enable = true;
	};
}

