{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [mullvad-closest];

  services.mullvad-vpn.enable = true;

  sops.secrets.mullvad_account_number = {
    sopsFile = ./secrets.yaml;
  };

  sops.templates.mullvad-post-start.content = ''
    mullvad account login '${config.sops.placeholder.mullvad_account_number}'
  '';

  systemd.services.mullvad-vpn.postStart = config.sops.templates.mullvad-post-start.content;
}
