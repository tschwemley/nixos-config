{ config, ... }: {
	programs.zsh = {
		autocd = true;
		enable = true;
		defaultKeymap = "vicmd";
		enableAutosuggestions = true;
		enableCompletion = true;
		history = {
		  extended = true; # store timestamps w/ history
		  size = 10000;
		  path = "${config.xdg.dataHome}/zsh/history";
		};
		#shellAliases = shellAliases;
	};

	programs.starship = {
	enable = true;
	enableBashIntegration = true;
	enableZshIntegration = true;
	# Configuration written to ~/.config/starship.toml
	settings = {
	  # add_newline = false;

	  # character = {
	  #   success_symbol = "[➜](bold green)";
	  #   error_symbol = "[➜](bold red)";
	  # };

	  # package.disabled = true;
	};
	};
}
