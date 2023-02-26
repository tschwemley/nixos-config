{ pkgs, ... }:
{
	home.packages = with pkgs; [ barrier ];
# TODO: if I want to make this into a standalone module then I need access to networking prop
	# networking.firewall.allowedTCPPorts = [ 24800 ];
	# iptables -A INPUT -p tcp --dport 24800 -s 192.168.1.100 -j ACCEPT
}
