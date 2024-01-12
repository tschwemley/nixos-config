{pkgs, ...}: {
  environment.systemPackages = with pkgs; [cmctl kubectl-cnpg];

  home-manager.users.root.config = {
    programs.k9s.enable = true;
  };

  home.file."" = {
    enable = true;
    source = ./k9s-config/clusters;
    target = ".local/share/k9s/clusters";
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
