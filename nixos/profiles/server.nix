{pkgs, ...}: {
  imports = [
	  ./.
	  ../modules/services/fail2ban.nix
  ];

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "me@tylerschwemley.com";
  # };
}
