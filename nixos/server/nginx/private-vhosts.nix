{config, ...}: {
  services.nginx.appendConfig = ''
    ${config.sops.templates.private_vhosts.content}
  '';

  sops.secrets.private_vhosts.sopsFile = ./secrets.yaml;

  sops.templates.private_vhosts = {
    group = config.users.users.nginx.group;
    owner = config.users.users.nginx.name;
    content = ''
      ${config.sops.placeholder.private_vhosts}
    '';
  };
}
