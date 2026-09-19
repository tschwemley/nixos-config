{
  self,
  pkgs,
  ...
}:
{
  imports = [ self.inputs.zen-browser.homeModules.default ];

  #
  programs.zen-browser = {
    enable = true;

    nativeMessagingHosts = with pkgs; [
      bitwarden-desktop
      firefoxpwa
    ];

    setAsDefaultBrowser = true;

    policies = import ./policies;
    profiles = import ./profiles self pkgs;
  };
}
