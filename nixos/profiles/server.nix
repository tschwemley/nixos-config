{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./.
    ../modules/services/fail2ban.nix
  ];

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  time.timeZone = lib.mkDefault "UTC";

  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "me@tylerschwemley.com";
  # };
}
