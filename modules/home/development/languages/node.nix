{ pkgs, ... }: {
	environment.systemPackages = with pkgs; [
		nodejs_18
	];
}
