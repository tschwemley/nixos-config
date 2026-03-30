{ self, pkgs, ... }:
{
  imports = [ self.inputs.zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;

    nativeMessagingHosts = [ pkgs.firefoxpwa ];

    policies = import ./policies.nix;
    profiles = import ./profiles pkgs;
  };
}
