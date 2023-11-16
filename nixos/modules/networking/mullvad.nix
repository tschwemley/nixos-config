{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		mullvad
		#mullvad-vpn
	];
}
