{pkgs, ...}: {
  environment.systemPackages = with pkgs; [cmctl kubectl-cnpg];

  home-manager.users.root.config = {
    programs.k9s = {
      enable = true;
    };

    settings.k9s = {
      namespace.favorites = [
        "all"
        "system"
        "web"
      ];
    };

    # xdg.dataFile = {
    #   "k9s/clusters/default/default/config.yaml".source = ./k9s-cluster-config.yaml;
    # };
  };

  networking.firewall.allowedTCPPorts = [
    6443 # api server
  ];

  programs.zsh = {
    shellAliases = {
      ctr = "k3s ctr";
      kubectl = "k3s kubectl";
    };
  };

  sops.secrets = {
    "schwem.io_github_key" = {
      sopsFile = ./secrets.yaml;
      path = "/root/.ssh/schwem.io-git";
    };
  };
}
