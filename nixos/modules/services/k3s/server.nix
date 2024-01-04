{pkgs, ...}: {
  environment.systemPackages = with pkgs; [cmctl kubectl-cnpg];

  networking.firewall.allowedTCPPorts = [
    6443 # api server
  ];

  programs.zsh.shellAliases = {
    ctr = "k3s ctr";
    kubectl = "k3s kubectl";
  };

  sops.secrets = {
    "schwem.io_github_key" = {
      sopsFile = ./secrets.yaml;
      path = "/root/.ssh/schwem.io-git";
    };
  };
}
