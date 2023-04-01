{ pkgs, ... }:

{
	programs.bat = {
		enable = true;
		extraPackages = with pkgs.bat-extras; [
			batdiff
			batwatch
		];
	};
}
