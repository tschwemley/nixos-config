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

  sops.templates.mullvad-post-start = {
    mode = "0700";
    content = ''
      mullvad account login '${config.sops.placeholder.mullvad_account_number}'
    '';
  };

  # systemd.services.mullvad-daemon.postStart = config.sops.templates.mullvad-post-start.content;
  # systemd.services.mullvad-vpn.postStart = ''
  #   ./${config.sops.templates.mullvad-post-start.path}
  # '';
}
