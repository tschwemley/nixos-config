{ self, pkgs, ... }:
{
  imports = [ self.inputs.zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;

    nativeMessagingHosts = [ pkgs.firefoxpwa ];

    policies = import ./policies.nix;

    # TODO: declarative config of profile
    # profiles = import ./profiles.nix pkgs;
  };
}
