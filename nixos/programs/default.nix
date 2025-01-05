{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    curl
    git
    gnupg
    jdupes
    jq
    lsof
    pinentry
    pwgen
    ripgrep
    rsync
    sops
    systemctl-tui
    tree
    unzip
    wget
    zip
  ];
}
