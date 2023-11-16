{pkgs, ...}: {
  imports = [./.];

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "me@tylerschwemley.com";
  # };
}
