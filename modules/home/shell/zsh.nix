{ ... }: {
	programs.zsh = {
		autocd = true;
		enable = true;
		defaultKeymap = "vicmd";
		enableAutosuggestions = true;
		enableCompletion = true;
		history = {
		  extended = true; # store timestamps w/ history
		  size = 10000;
		  # path = "${config.xdg.dataHome}/zsh/history";
		};
		#shellAliases = shellAliases;
	};
}
