{
  self,
  pkgs,
  ...
}:
{
  imports = [ self.inputs.zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;

    # BUG: https://github.com/NixOS/nixpkgs/pull/525720
    # TODO: uncomment after upstream bug resolved
    nativeMessagingHosts = with pkgs; [
      bitwarden-desktop
      firefoxpwa
    ];

    setAsDefaultBrowser = true;

    policies = import ./policies;
    profiles = import ./profiles self pkgs;
  };
}
